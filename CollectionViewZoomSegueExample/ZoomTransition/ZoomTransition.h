//
//  ZoomTransition.h
//  CollectionViewZoomSegueExample
//
//  Created by Denys Telezhkin on 29.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomTransition : UIPercentDrivenInteractiveTransition <UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>

- (instancetype)initWithNavigationController:(UINavigationController *)nc;

@property (nonatomic, assign) UINavigationController * navigationController;

@property (nonatomic, assign) CGFloat transitionDuration;

@end
