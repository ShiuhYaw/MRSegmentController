//
//  MRTitleHistoryTableViewCell.h
//  MRTitleRoonViewController
//
//  Created by Yaw on 17/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRTitleHistoryItemStyle) {
    
    MRTitleHistoryItemStyleNone = 0,
    MRTitleHistoryItemStyleCoin,
    MRTitleHistoryItemStyleDiamond,
    MRTitleHistoryItemStyleTitle,
} NS_ENUM_AVAILABLE_IOS(8_0);


NS_ASSUME_NONNULL_BEGIN
NS_CLASS_AVAILABLE_IOS(8_0) @interface MRTitleHistoryItem : NSObject <NSCopying>

+ (instancetype)itemWithTitle:(NSString *)title titleImage:(id)titleImg style:(MRTitleHistoryItemStyle)style;
@property (nullable, nonatomic, readonly) id titleImage;
@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) MRTitleHistoryItemStyle style;
@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface MRTitleHistoryTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *durationString;
@property (nonatomic, strong) NSArray<MRTitleHistoryItem *> *itemsArray;;

@end
NS_ASSUME_NONNULL_END
