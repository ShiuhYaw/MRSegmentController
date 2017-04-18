//
//  MRTitleHistorySegmentViewController.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 17/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleHistorySegmentViewController.h"
#import "MRTitleHistoryCollectionViewController.h"
#import "constants.h"
#import "UIView+Orientation.h"

@interface MRTitleHistorySegmentViewController ()

@end

@implementation MRTitleHistorySegmentViewController

- (instancetype)init {
    
    MRTitleHistoryCollectionViewController *titleHistoryCollectionViewController = [[MRTitleHistoryCollectionViewController alloc]initWithNibName:NSStringFromClass([MRTitleHistoryCollectionViewController class]) bundle:nil];
    self = [super initWithControllers:titleHistoryCollectionViewController, nil];
    if (self) {
//        if ([self.view isViewOrientationLandscape]) {
//            self.segmentMiniTopInset = kNavigationHeight / 2;
//            self.headerHeight = kNavigationHeight / 2;
//        }
//        else if ([self.view isViewOrientationPortrait]) {
            self.segmentMiniTopInset = kNavigationHeight;
            self.headerHeight = kNavigationHeight;
//        }
        self.freezenHeaderWhenReachMaxHeaderheight = YES;
    }
    return self;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        if ([self.view isViewOrientationLandscape]) {
            self.segmentMiniTopInset = kNavigationHeight / 2;
            self.headerHeight = kNavigationHeight / 2;
        }
        else if ([self.view isViewOrientationPortrait]) {
            self.segmentMiniTopInset = kNavigationHeight;
            self.headerHeight = kNavigationHeight / 2;
        }
    }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = self.currentDisplayController.segmentTitle;
    // Do any additional setup after loading the view.
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
