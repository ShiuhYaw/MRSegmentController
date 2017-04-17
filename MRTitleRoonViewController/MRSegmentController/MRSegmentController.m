//
//  MRSegmentController.m
//  MRTitleRoomController
//
//  Created by Yaw on 12/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRSegmentController.h"
#import "MRSegmentView.h"

const void *MRSEGMENT_CURRENT_SCROLLVIEWOFFSET = &MRSEGMENT_CURRENT_SCROLLVIEWOFFSET;
const void *MRSEGMENT_CURRENT_SCROLLVIEWINSET = &MRSEGMENT_CURRENT_SCROLLVIEWINSET;

@interface MRSegmentController ()

@property (nonatomic, strong) UIView<MRSegmentControllerHeaderProtocol> *headerView;
@property (nonatomic, strong) MRSegmentView *segmentView;
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, assign) CGFloat segmentTopInset;
@property (nonatomic, weak) UIViewController<MRSegmentControllerDelegate> *currentDisplayController;
@property (nonatomic, strong) NSLayoutConstraint *headerHeightConstraint;
@property (nonatomic, strong) NSHashTable *hasShownControllers;
@property (nonatomic, assign) BOOL ignoreOffsetChanged;
@property (nonatomic, assign) CGFloat originalTopInset;

@end

@implementation MRSegmentController

- (instancetype)initWithControllers:(UIViewController<MRSegmentControllerDelegate> *)controller, ... {
    
    self = [super init];
    if (self) {
        
        NSAssert(controller != nil, @"the first controller must not be nil!");
        [self setup];
        UIViewController<MRSegmentControllerDelegate> *eachController;
        va_list argumentList;
        if (controller) {
            [self.controllers addObject:controller];
            va_start(argumentList, controller);
            while ((eachController = va_arg(argumentList, id))) {
                [self.controllers addObject:eachController];
            }
            va_end(argumentList);
        }
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setup];
    }
    return  self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self baseConfigs];
    [self baseLayout];
}

#pragma mark - Public Methods

- (void)setViewControllers:(NSArray *)viewControllers {
    
    [self.controllers removeAllObjects];
    [self.controllers addObjectsFromArray:viewControllers];
}

#pragma mark - Private Methods

- (UIView<MRSegmentControllerHeaderProtocol> *)customHeaderView {
    
    return [[MRSegmentHeaderView alloc] init];
}

- (void)setup {
    
    self.ignoreOffsetChanged = NO;
    self.headerHeight = 400;
    self.segmentHeight = 62.5;
    self.segmentTopInset = 400;
    self.segmentMiniTopInset = 0;
    self.controllers = [NSMutableArray array];
    self.hasShownControllers = [NSHashTable weakObjectsHashTable];
}

- (void)baseConfigs {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self.view respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        
        self.view.preservesSuperviewLayoutMargins = YES;
    }
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.headerView = [self customHeaderView];
    self.headerView.clipsToBounds = YES;
    [self.view addSubview:self.headerView];
    
    self.segmentView = [MRSegmentView segmentView];
    [self.segmentView.segmentControl removeAllSegments];
    [self.segmentView.segmentControl addTarget:self action:@selector(segmentControlDidChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentView];
    
    if (self.controllers.count <= 1) {
        self.segmentHeight = 0;
        self.segmentView.hidden = YES;
    }
    
    [self.controllers enumerateObjectsUsingBlock:^(UIViewController<MRSegmentControllerDelegate> *controller, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = [controller segmentTitle];
        [self.segmentView.segmentControl insertSegmentWithTitle:title atIndex:idx animated:NO];
        [self.segmentView.segmentControl setWidth:109 forSegmentAtIndex:idx];
    }];
    self.segmentView.segmentControl.selectedSegmentIndex = 0;
    UIViewController<MRSegmentControllerDelegate> *controller = self.controllers[0];
    [controller willMoveToParentViewController:self];
    [self.view insertSubview:controller.view atIndex:0];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];

    [self layoutControllerWithController:controller];
    [self addObserverForController:controller];
    self.currentDisplayController = self.controllers[0];
}

- (void)baseLayout {
    
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.headerView
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:0
                                                              multiplier:1
                                                                constant:self.headerHeight];
    [self.headerView addConstraint:self.headerHeightConstraint];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:0]];
    self.segmentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.headerView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]];
    [self.segmentView addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:0
                                                                multiplier:1
                                                                  constant:self.segmentHeight]];
}

- (void)layoutControllerWithController:(UIViewController<MRSegmentControllerDelegate> *)pageController {
    
    UIView *pageView = pageController.view;
    if ([pageView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        
        pageView.preservesSuperviewLayoutMargins = YES;
    }
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1
                                                           constant:0]];
    UIScrollView *scrollView = [self scrollViewInController:pageController];
    if (scrollView) {
        
        scrollView.alwaysBounceVertical = YES;
        self.originalTopInset = self.headerHeight + self.segmentHeight;
        CGFloat bottomInset = 0;
        if (self.tabBarController.tabBar.hidden == NO) {
            
            bottomInset = CGRectGetHeight(self.tabBarController.tabBar.bounds);
        }
        [scrollView setContentInset:UIEdgeInsetsMake(self.originalTopInset, 0, bottomInset, 0)];
        if (![self.hasShownControllers containsObject:pageController]) {
            
            [self.hasShownControllers addObject:pageController];
            [scrollView setContentOffset:CGPointMake(0, -self.headerHeight - self.segmentHeight)];
        }
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1
                                                               constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1
                                                               constant:0]];
    }
    else {
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.segmentView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1
                                                               constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1
                                                               constant:-self.segmentHeight]];
    }
}

- (UIScrollView *)scrollViewInController:(UIViewController<MRSegmentControllerDelegate> *)controller {
    
    if ([controller respondsToSelector:@selector(streachScrollView)]) {
        
        return [controller streachScrollView];
    }
    else if ([controller.view isKindOfClass:[UIScrollView class]]) {
        
        return (UIScrollView *)controller.view;
    }
    else {
        
        return nil;
    }
}

#pragma mark - add / remove observer for scrollview

- (void)addObserverForController:(UIViewController<MRSegmentControllerDelegate> *)controller {
    
    UIScrollView *scrollView = [self scrollViewInController:controller];
    if (scrollView != nil) {
        
        [scrollView addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(contentOffset))
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                        context:&MRSEGMENT_CURRENT_SCROLLVIEWOFFSET];
        [scrollView addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(contentInset))
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                        context:&MRSEGMENT_CURRENT_SCROLLVIEWINSET];
    }
}

- (void)removeObserverForController:(UIViewController<MRSegmentControllerDelegate> *)controller {
    
    UIScrollView *scrollView = [self scrollViewInController:controller];
    if (scrollView != nil) {
        
        @try {
            [scrollView removeObserver:self
                            forKeyPath:NSStringFromSelector(@selector(contentOffset))];
            [scrollView removeObserver:self
                            forKeyPath:NSStringFromSelector(@selector(contentInset))];
        } @catch (NSException *exception) {
            NSLog(@"exception is %@", exception);
        } @finally {
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == MRSEGMENT_CURRENT_SCROLLVIEWOFFSET && !self.ignoreOffsetChanged) {
        
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat offsetY = offset.y;
        CGPoint oldOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
        CGFloat oldOffsetY = oldOffset.y;
        CGFloat deltaOfOffsetY = offset.y - oldOffsetY;
        CGFloat offsetYWithSegment = offset.y + self.segmentHeight;
        if (deltaOfOffsetY > 0 && offsetY >= -(self.headerHeight + self.segmentHeight)) {
            
            if (self.headerHeightConstraint.constant - deltaOfOffsetY <= 0) {
                
                self.headerHeightConstraint.constant = self.segmentMiniTopInset;
            }
            else {
                
                self.headerHeightConstraint.constant -= deltaOfOffsetY;
            }
            if (self.headerHeightConstraint.constant <= self.segmentMiniTopInset) {
                
                self.headerHeightConstraint.constant = self.segmentMiniTopInset;
            }
        }
        else {
            
            if (offsetY > 0) {
                
                if (self.headerHeightConstraint.constant <= self.segmentMiniTopInset) {
                    
                    self.headerHeightConstraint.constant = self.segmentMiniTopInset;
                }
            }
            else {
                
                if (self.headerHeightConstraint.constant >= self.headerHeight) {
                    
                    if (-offsetYWithSegment > self.headerHeight && !self.freezenHeaderWhenReachMaxHeaderheight) {
                        
                        self.headerHeightConstraint.constant = -offsetYWithSegment;
                    }
                    else {
                        
                        self.headerHeightConstraint.constant = self.headerHeight;
                    }
                }
                else {
                    
                    if (self.headerHeightConstraint.constant < -offsetYWithSegment) {
                        
                        self.headerHeightConstraint.constant -= deltaOfOffsetY;
                    }
                }
            }
        }
        self.segmentTopInset = self.headerHeightConstraint.constant;
    }
    else if (context == MRSEGMENT_CURRENT_SCROLLVIEWINSET) {
        
        UIEdgeInsets insets = [object contentInset];
        if (fabs(insets.top - self.originalTopInset) < 2) {
            
            self.ignoreOffsetChanged = NO;
        }
        else {
            
            self.ignoreOffsetChanged = YES;
        }
    }
    
}

#pragma mark - Event Methods

- (void)segmentControlDidChangedValue:(UISegmentedControl *)sender {
    
    // remove observer
    [self removeObserverForController:self.currentDisplayController];
    
    // add new controller
    NSUInteger index = [sender selectedSegmentIndex];
    UIViewController<MRSegmentControllerDelegate> *controller = self.controllers[index];
    [self.currentDisplayController willMoveToParentViewController:nil];
    [self.currentDisplayController.view removeFromSuperview];
    [self.currentDisplayController removeFromParentViewController];
    [self.currentDisplayController didMoveToParentViewController:nil];
    
    [controller willMoveToParentViewController:self];
    [self.view insertSubview:controller.view atIndex:0];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    
    // reset current controller
    self.currentDisplayController = controller;
    // layout new controller
    [self layoutControllerWithController:controller];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    // trigger to fixed header constraint
    UIScrollView *scrollView = [self scrollViewInController:controller];
    if (self.headerHeightConstraint.constant != self.headerHeight) {
        
        if (scrollView.contentOffset.y >= -(self.segmentHeight + self.headerHeight) && scrollView.contentOffset.y <= -self.segmentHeight) {
            
            [scrollView setContentOffset:CGPointMake(0, -self.segmentHeight - self.headerHeightConstraint.constant)];
        }
    }
    // add observer
    [self addObserverForController:self.currentDisplayController];
    [scrollView setContentOffset:scrollView.contentOffset];
}

- (void)dealloc {
    
    [self removeObserverForController:self.currentDisplayController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
