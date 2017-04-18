//
//  MRTitleRoomHeaderViewController.m
//  MRTitleRoomController
//
//  Created by Yaw on 13/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleRoomHeaderViewController.h"
#import "MRNavigationControllerViewController.h"
#import "MRTitleRoomCollectionViewController.h"
#import "MRTitleRoomHeader.h"
#import "MRSegmentView.h"
#include "constants.h"
#import "UIView+Orientation.h"

void *RoomHeaderInsetObserver = &RoomHeaderInsetObserver;

@interface MRTitleRoomHeaderViewController()

@property (nonatomic, strong) MRTitleRoomHeader *titleRoomHeaderView;

@end

@implementation MRTitleRoomHeaderViewController

- (instancetype)init {
    
    MRTitleRoomCollectionViewController *collectionView = [[MRTitleRoomCollectionViewController alloc] initWithNibName:NSStringFromClass([MRTitleRoomCollectionViewController class]) bundle:nil];
    self = [super initWithControllers:collectionView, nil];
    if (self) {
//        if ([self.view isViewOrientationLandscape]) {
//            self.segmentMiniTopInset = kNavigationHeight / 2;
//            self.headerHeight = kHeaderHeight;
//        }
//        else if ([self.view isViewOrientationPortrait]) {
            self.segmentMiniTopInset = kNavigationHeight;
            self.headerHeight = kHeaderHeight;
//        }
        self.freezenHeaderWhenReachMaxHeaderheight = YES;
    }
    return self;
}

- (UIView<MRSegmentControllerHeaderProtocol> *)customHeaderView {
    
    if (self.titleRoomHeaderView == nil) {
        
        self.titleRoomHeaderView = [MRTitleRoomHeader titleRoomHeaderView];
    }
    return self.titleRoomHeaderView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = self.currentDisplayController.segmentTitle;
    [self addObserver:self forKeyPath:kSegmentTopInset options:NSKeyValueObservingOptionNew context:RoomHeaderInsetObserver];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.titleRoomHeaderView updateHeadPhotoWithTopInset:kHeaderHeight];
    [(MRNavigationControllerViewController *)self.navigationController updateWithTopInset:kHeaderHeight];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.titleRoomHeaderView updateHeadPhotoWithTopInset:kNavigationHeight];
    [(MRNavigationControllerViewController *)self.navigationController updateWithTopInset:kNavigationHeight];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        if ([self.view isViewOrientationLandscape]) {
            self.segmentMiniTopInset = kNavigationHeight / 2;
            self.headerHeight = kHeaderHeight;
        }
        else if ([self.view isViewOrientationPortrait]) {
            self.segmentMiniTopInset = kNavigationHeight;
            self.headerHeight = kHeaderHeight;
        }
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if (context == RoomHeaderInsetObserver) {
        CGFloat inset = [change[NSKeyValueChangeNewKey] floatValue];
        [self.titleRoomHeaderView updateHeadPhotoWithTopInset:inset];
        [(MRNavigationControllerViewController *)self.navigationController updateWithTopInset:inset];
    }
}

- (void)dealloc {
    
    [super removeObserver:self forKeyPath:kSegmentTopInset];
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
