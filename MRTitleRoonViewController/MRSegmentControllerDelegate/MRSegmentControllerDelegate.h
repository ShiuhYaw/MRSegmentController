//
//  MRSegmentControllerDelegate.h
//  MRTitleRoomController
//
//  Created by Yaw on 12/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

@protocol MRSegmentControllerDelegate <NSObject>

- (NSString *)segmentTitle;

@optional
- (UIScrollView *)streachScrollView;

@end
