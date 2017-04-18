//
//  UIView+Orientation.m
//  MRTitleRoonViewController
//
//  Created by Yaw on 18/4/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "UIView+Orientation.h"

@implementation UIView (Orientation)

+ (ViewOrientation)viewOrientationForSize:(CGSize)size {
    return (size.width > size.height) ? ViewOrientationLandscape : ViewOrientationPortrait;
}

- (ViewOrientation)viewOrientation {
    return [[self class] viewOrientationForSize:self.bounds.size];
}

- (BOOL)isViewOrientationPortrait {
    return [self viewOrientation] == ViewOrientationPortrait;
}

- (BOOL)isViewOrientationLandscape {
    return [self viewOrientation] == ViewOrientationLandscape;
}

@end
