//
//  MRSegmentView.m
//  MRTitleRoomController
//
//  Created by Yaw on 12/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRSegmentView.h"

@interface MRSegmentViewOwner : NSObject

@property (weak, nonatomic) IBOutlet MRSegmentView *segmentView;
@end

@implementation MRSegmentViewOwner
@end

@interface MRSegmentView()

@end

@implementation MRSegmentView

+ (instancetype)segmentView {
    
    MRSegmentViewOwner *owner = [MRSegmentViewOwner new];
    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MRSegmentView class])
                                 owner:owner
                               options:nil];
    return owner.segmentView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

@end
