//
//  MRTitleHistoryCollectionViewCell.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 18/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleHistoryCollectionViewCell.h"

@interface MRTitleHistoryCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *view;

@end

@implementation MRTitleHistoryCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.borderColor = [UIColor colorWithRed:(226/255.0f) green:(226/255.0f) blue:(226/255.0f) alpha:1.0].CGColor;
    self.view.layer.borderWidth = 0.5;
    self.view.layer.cornerRadius = 5;
}

@end
