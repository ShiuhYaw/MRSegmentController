//
//  MRTitleBottomButtonCollectionViewCell.m
//  MRTitleRoomController
//
//  Created by Yaw on 13/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleBottomButtonCollectionViewCell.h"

@implementation MRTitleBottomButtonCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.button.layer.cornerRadius = self.button.frame.size.height / 2;
}

@end
