//
//  MRTitleRoomHeader.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 17/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleRoomHeader.h"
#import "GLWave.h"
#import "GLWaveView.h"
#include "constants.h"

@interface MRTitleRoomHeaderOwner : NSObject

@property (weak, nonatomic) IBOutlet MRTitleRoomHeader *titleRoomHeader;
@end

@implementation MRTitleRoomHeaderOwner
@end

@interface MRTitleRoomHeader()

@property (nonatomic, assign) CGFloat ratioProfileImageHeight;
@property (nonatomic, strong) GLWave *waveA;
@property (nonatomic, strong) GLWave *waveB;
@property (nonatomic, strong) GLWave *waveC;

@end

@implementation MRTitleRoomHeader

+ (instancetype)titleRoomHeaderView {
    
    MRTitleRoomHeaderOwner *owner = [MRTitleRoomHeaderOwner new];
    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MRTitleRoomHeader class])
                                 owner:owner
                               options:nil];
    return owner.titleRoomHeader;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    GLWaveView *view = [[GLWaveView alloc] initWithFrame:self.waveView.bounds];
    self.waveA = [GLWave defaultWave];
    self.waveA.offsetX = kWaveOffsetX;
    self.waveA.offsetY = kRatioConstant / 3;
    self.waveA.height  = kWaveHeight;
    self.waveA.width   = self.bounds.size.width;
    self.waveA.speedX  = kWaveSpeed1;
    self.waveA.fillColor = [UIColor colorWithWhite:1 alpha:0.250].CGColor;
    
    self.waveB = [GLWave defaultWave];
    self.waveB.offsetX = kWaveOffsetX;
    self.waveB.offsetY = kRatioConstant / 3 * 2;
    self.waveB.height  = kWaveHeight;
    self.waveB.width   = self.bounds.size.width;
    self.waveB.speedX  = kWaveSpeed2;
    self.waveB.fillColor = [UIColor colorWithWhite:1 alpha:0.250].CGColor;
    
    self.waveC = [GLWave defaultWave];
    self.waveC.offsetX = kWaveOffsetX;
    self.waveC.offsetY = kRatioConstant;
    self.waveC.height  = kWaveHeight;
    self.waveC.width   = self.bounds.size.width;
    self.waveC.speedX  = kWaveSpeed3;
    self.waveC.fillColor = [UIColor colorWithWhite:1 alpha:0.250].CGColor;
    
    [view addWave:self.waveA];
    [view addWave:self.waveB];
    [view addWave:self.waveC];
    
    [self.waveView addSubview:view];
    [view startWaveAnimate];
    self.ratioProfileImageHeight = self.heightConstraint.constant / 1.7f;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2;
    self.profileImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.profileImageView.layer.borderWidth = 2;
    self.waveA.width   = self.bounds.size.width;
    self.waveB.width   = self.bounds.size.width;
    self.waveC.width   = self.bounds.size.width;
}

- (UIImageView *)backgroundImageView {
    
    return self.imageView;
}

- (void)updateHeadPhotoWithTopInset:(CGFloat)inset {
    
    CGFloat ratio = (inset - kNavigationHeight)/(kHeaderHeight - kNavigationHeight);
    self.heightConstraint.constant = self.ratioProfileImageHeight + ratio * kRatioConstant;
    self.profileImageView.alpha = ratio;
    self.profileImageView.layer.cornerRadius = self.heightConstraint.constant / 2;
}

@end
