//
//  MRSegmentController.h
//  MRTitleRoomController
//
//  Created by Yaw on 12/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRSegmentControllerHeaderProtocol.h"
#import "MRSegmentControllerDelegate.h"
#import "MRSegmentHeaderView.h"

@class MRSegmentView;
@interface MRSegmentController : UIViewController

@property (nonatomic, assign) CGFloat segmentHeight;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat segmentMiniTopInset;
@property (nonatomic, assign, readonly) CGFloat segmentTopInset;
@property (nonatomic, assign) BOOL freezenHeaderWhenReachMaxHeaderheight;
@property (nonatomic, weak, readonly) UIViewController<MRSegmentControllerDelegate> *currentDisplayController;
@property (nonatomic, strong, readonly) MRSegmentView *segmentView;
@property (nonatomic, strong, readonly) UIView<MRSegmentControllerHeaderProtocol> *headerView;

- (instancetype)initWithControllers:(UIViewController<MRSegmentControllerDelegate> *)controller, ... NS_REQUIRES_NIL_TERMINATION;
- (void)setViewControllers:(NSArray *)viewControllers;
- (UIView<MRSegmentControllerHeaderProtocol> *)customHeaderView;

@end
