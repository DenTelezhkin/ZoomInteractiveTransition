//
//  ZoomTransition.h
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 29.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import "ZoomTransitionProtocol.h"

@interface ZoomInteractiveTransition : UIPercentDrivenInteractiveTransition <UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) UINavigationController * navigationController;

@property (nonatomic, assign) CGFloat transitionDuration;

@property (nonatomic, assign) BOOL handleEdgePanBackGesture;

@property (nonatomic, assign) UIViewKeyframeAnimationOptions transitionAnimationOption;

- (instancetype)initWithNavigationController:(UINavigationController *)nc;

@end
