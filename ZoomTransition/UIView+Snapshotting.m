//
//  UIView+Snapshotting.m
//  ZoomTransitionExample
//
//  Created by Denys Telezhkin on 03.07.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import "UIView+Snapshotting.h"

@implementation UIView (Snapshotting)

-(UIImage *)dt_takeSnapshot
{
    // Use pre iOS-7 snapshot API since we need to render views that are off-screen.
    // iOS 7 snapshot API allow us to snapshot only things on screen
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

@end
