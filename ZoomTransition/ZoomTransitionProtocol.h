//
//  ZoomTransitionProtocol.h
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 30.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZoomAnimationBlock)(UIImageView * animatedSnapshot, UIView * sourceView, UIView * destinationView);

/**
 ZoomTransitionProtocol should be implemented by UIViewControllers, that wish to participate in zoom transition.
 */

@protocol ZoomTransitionProtocol <NSObject>

/**
 UIView, that will be used for zoom transition. Both source and destination view controllers need to implement this method, otherwise ZoomInteractiveTransition will not be performed. 
 
 @return UIView, that will participate in transition.
 */
-(UIView *)viewForZoomTransition;

@optional

/**
 By default, ZoomInteractiveTransition will choose bigger snapshot from source and destination view snapshots. Initial chosen snapshot will be passed to this method. You may choose to change it, or provide completely different snapshot that suits your needs better. Keep in mind, snapshot will be resized to destination view frame.
 
 @param snapshot Snapshot, that was prepared by ZoomInteractiveTransition 
 
 @return snapshot, that you wish to use for zoom animation.
 */
-(UIImageView *)initialZoomViewSnapshotFromProposedSnapshot:(UIImageView *)snapshot;


/**
 Custom animation block, that will be called inside UIView animateKeyFramesWithDuration:delay:options:animations:completion: method alongside with zooming animation. You can add your own keyframes to animation if you need.
 
 @return Animation block.
 */
-(ZoomAnimationBlock)animationBlockForZoomTransition;

@end
