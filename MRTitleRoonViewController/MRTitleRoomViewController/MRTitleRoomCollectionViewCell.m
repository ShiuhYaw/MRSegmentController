//
//  MRTitleRoomCollectionViewCell.m
//  MRTitleRoomController
//
//  Created by Yaw on 13/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleRoomCollectionViewCell.h"

@implementation MRTitleRoomCollectionViewCell

- (NSString *)extractNumberFromText:(NSString *)text
{
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [[text componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    NSRange range = [self.titleLabel.text rangeOfString:[self extractNumberFromText:self.titleLabel.text]];
    NSRange percentageRange = [self.titleLabel.text rangeOfString:@"%"];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]
                       range:range];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithRed:(44/255.0f) green:(44/255.0f) blue:(48/255.0f) alpha:1.0]
                       range:range];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0]
                       range:percentageRange];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithRed:(44/255.0f) green:(44/255.0f) blue:(48/255.0f) alpha:1.0]
                       range:percentageRange];
    self.titleLabel.attributedText = attrString;
}

@end
