//
//  UIView+Snapshotting.h
//  ZoomTransitionExample
//
//  Created by Denys Telezhkin on 03.07.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Snapshotting)

/**
  Take snapshot of a view by using pre-iOS 7 snapshotting.
 
 @return UIImage of rendered UIView.
 */
-(UIImage *)dt_takeSnapshot;

@end
