//
//  MRTitleRoomHeader.h
//  MRTitleRoonViewController
//
//  Created by Yaw on 17/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRSegmentControllerHeaderProtocol.h"

@interface MRTitleRoomHeader : UIView <MRSegmentControllerHeaderProtocol>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *waveCoverView;
@property (weak, nonatomic) IBOutlet UIView *waveView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

+ (instancetype)titleRoomHeaderView;
- (void)updateHeadPhotoWithTopInset:(CGFloat)inset;

@end
