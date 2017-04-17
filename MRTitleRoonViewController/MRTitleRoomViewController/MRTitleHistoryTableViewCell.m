//
//  MRTitleHistoryTableViewCell.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 17/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRTitleHistoryTableViewCell.h"

@interface MRTitleHistoryItem()

@property (strong, nonatomic) id titleImg;
@property (strong, nonatomic) NSString *titleString;
@property (assign, nonatomic) MRTitleHistoryItemStyle valueStyle;

@end

@implementation MRTitleHistoryItem

+ (instancetype)itemWithTitle:(NSString *)title titleImage:(id)titleImg style:(MRTitleHistoryItemStyle)style {
    
    MRTitleHistoryItem *alertItem = [[MRTitleHistoryItem alloc] init];
    alertItem.titleImg = titleImg;
    alertItem.titleString = title;
    alertItem.valueStyle = style;
    return alertItem;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    
    MRTitleHistoryItem *alertItem = [[[self class] allocWithZone:zone] init];
    alertItem.titleString = self.titleString;
    alertItem.titleImg = self.titleImg;
    alertItem.valueStyle = self.style;
    return alertItem;
}

- (id)titleImage {
    
    return self.titleImg;
}

- (NSString *)title {
    
    return self.titleString;
}

- (void)dealloc {
    
    self.titleImg = nil;
    self.titleString = nil;
}

@end

@interface MRTitleHistoryTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIView *firstItemView;
@property (weak, nonatomic) IBOutlet UILabel *firstItemLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstItemImageView;

@property (weak, nonatomic) IBOutlet UIView *secondItemView;
@property (weak, nonatomic) IBOutlet UILabel *secondItemLabel;
@property (weak, nonatomic) IBOutlet UIImageView *secondItemImageView;

@end

@implementation MRTitleHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.firstItemView.layer.borderColor = [UIColor colorWithRed:(226/255.0f) green:(226/255.0f) blue:(226/255.0f) alpha:1.0f].CGColor;
    self.firstItemView.layer.borderWidth = 0.5;
    self.firstItemView.layer.cornerRadius = 5.0f;
    
    self.secondItemView.layer.borderColor = [UIColor colorWithRed:(226/255.0f) green:(226/255.0f) blue:(226/255.0f) alpha:1.0f].CGColor;
    self.secondItemView.layer.borderWidth = 0.5;
    self.secondItemView.layer.cornerRadius = 5.0f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDurationString:(NSString *)durationString {
    
    if (durationString.length > 0) {
        
        self.durationLabel.text = durationString;
    }
}

- (void)setItemsArray:(NSArray<MRTitleHistoryItem *> *)itemsArray {
    
    self.firstItemView.hidden = true;
    self.secondItemView.hidden = true;
    
    if (itemsArray.count <= 0) {
        
        self.firstItemView.hidden = true;
        self.secondItemView.hidden = true;
        return;
    }
    
    for (MRTitleHistoryItem *item in itemsArray) {
        
        if (item.style == MRTitleHistoryItemStyleTitle) {
            break;
        }
        switch (item.style) {
            case MRTitleHistoryItemStyleCoin:
                
                self.secondItemLabel.text = item.title;
                self.secondItemView.hidden = false;
                break;
            case MRTitleHistoryItemStyleDiamond:
                
                self.firstItemLabel.text = item.title;
                self.firstItemView.hidden = false;
                break;
            default:
                break;
        }
    }
    
    if (itemsArray.count > 1) {
        
        MRTitleHistoryItem *item1 = itemsArray[1];
        self.secondItemLabel.text = item1.title;
        self.secondItemLabel.hidden = false;
    }
    if (itemsArray.count > 0) {
        
        MRTitleHistoryItem *item2 = itemsArray[0];
        self.firstItemLabel.text = item2.title;
        self.firstItemView.hidden = false;
    }
}

@end
