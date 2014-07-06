//
//  ZoomTransitionProtocol.h
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 30.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZoomAnimationBlock)(UIImageView * animatedSnapshot, UIView * sourceView, UIView * destinationView);

@protocol ZoomTransitionProtocol <NSObject>

-(UIView *)viewForZoomTransition;

@optional

-(UIImageView *)initialZoomViewSnapshotFromProposedSnapshot:(UIImageView *)snapshot;

-(ZoomAnimationBlock)animationBlockForZoomTransition;

@end
