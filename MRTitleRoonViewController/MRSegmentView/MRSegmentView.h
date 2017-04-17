//
//  MRSegmentView.h
//  MRTitleRoomController
//
//  Created by Yaw on 12/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRSegmentView : UIView

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UIView *bottomLine;

+ (instancetype)segmentView;

@end
