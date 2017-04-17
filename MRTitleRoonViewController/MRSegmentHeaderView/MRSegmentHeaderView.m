//
//  MRSegmentHeaderView.m
//  MRTitleRoomController
//
//  Created by Yaw on 12/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRSegmentHeaderView.h"
#import "UIColor+CrossFade.h"

@interface MRSegmentHeaderView()

@property(nonatomic, strong) NSLayoutConstraint *imageTopConstraint;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MRSegmentHeaderView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self baseConfigs];
    }
    return self;
}

- (UIImage *)createImageWithColor:(UIColor *)color {
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)baseConfigs {
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [self createImageWithColor:[UIColor whiteColor]];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self
     addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:self
                                                attribute:NSLayoutAttributeLeft
                                               multiplier:1
                                                 constant:0]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.imageView
                         attribute:NSLayoutAttributeRight
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:0]];
    self.imageTopConstraint =
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0];
    [self addConstraint:self.imageTopConstraint];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.imageView
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
}

- (UIImageView *)backgroundImageView {
    
    return self.imageView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}

@end
