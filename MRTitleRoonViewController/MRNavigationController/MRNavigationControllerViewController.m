//
//  MRNavigationControllerViewController.m
//  MRTitleRoomController
//
//  Created by Yaw on 13/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRNavigationControllerViewController.h"
#import "UIColor+CrossFade.h"
#include "constants.h"

@interface MRNavigationControllerViewController ()

@end

@implementation MRNavigationControllerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                               [UIColor whiteColor],NSForegroundColorAttributeName,
//                                               [UIFont fontWithName:@"HelveticaNeue-Bold" size:16],
//                                               NSFontAttributeName, nil];
//    
//    [self.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
//    [self.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
//    [self.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationBar setTranslucent:YES];
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

- (void)updateWithTopInset:(CGFloat)inset {
    
    CGFloat ratio = (inset - kNavigationHeight)/(kHeaderHeight - kNavigationHeight);
    UIColor *colorA = [UIColor blackColor];
    UIColor *colorB = [UIColor whiteColor];
    UIColor *crossFade = [UIColor colorForFadeBetweenFirstColor:colorA secondColor:colorB atRatio:ratio];
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               crossFade,NSForegroundColorAttributeName,
                                               [UIFont fontWithName:@"HelveticaNeue-Bold" size:16],
                                               NSFontAttributeName, nil];
    [self.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
    [self.navigationBar setTintColor:crossFade];
    UIColor *navigationColorA = [UIColor whiteColor];
    UIColor *navigationColorB = [UIColor clearColor];
    UIColor *navigationCrossFade = [UIColor colorForFadeBetweenFirstColor:navigationColorA secondColor:navigationColorB atRatio:ratio];
    [self.navigationBar setBackgroundImage:[self createImageWithColor:navigationCrossFade] forBarMetrics:UIBarMetricsDefault];
    UIColor *navigationShodowColorA = [UIColor colorWithRed:(226/255.0f) green:(226/255.0f) blue:(226/255.0f) alpha:1.0];
    UIColor *navigationShodowColorB = [UIColor clearColor];
    UIColor *navigationShodowCrossFade = [UIColor colorForFadeBetweenFirstColor:navigationShodowColorA secondColor:navigationShodowColorB atRatio:ratio];
    [self.navigationBar setShadowImage:[self createImageWithColor:navigationShodowCrossFade]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
