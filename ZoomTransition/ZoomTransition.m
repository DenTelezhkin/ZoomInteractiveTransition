//
//  ZoomTransition.m
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 29.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import "ZoomTransition.h"
#import "ZoomTransitionProtocol.h"
#import "UIView+Snapshotting.h"

@interface ZoomTransition()

@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, assign) BOOL shouldCompleteTransition;
@property (nonatomic, assign, getter = isInteractive) BOOL interactive;


@end

@implementation ZoomTransition

- (instancetype)initWithNavigationController:(UINavigationController *)nc
{
    if (self = [super init]) {
        self.navigationController = nc;
        self.transitionDuration = 1;
        [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(handleEdgePan:)];
        nc.delegate = self;
    }
    
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController <ZoomTransitionProtocol> * fromVC = (id)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <ZoomTransitionProtocol> *toVC = (id)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = [fromVC view];
    UIView * toView = [toVC view];
    
    [containerView addSubview:toView];
    
    UIView * zoomFromView = [fromVC viewForZoomTransition:self];
    UIView * zoomToView = [toVC viewForZoomTransition:self];
    
    UIImage * fromSnapshot = [zoomFromView dt_takeSnapshot];
    UIImage * toSnapshot = [zoomToView dt_takeSnapshot];
    
    
    fromView.alpha = 1;
    toView.alpha = 0;
    
    UIScreenEdgePanGestureRecognizer *edgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePan:)];
    edgePanRecognizer.edges = UIRectEdgeLeft;
    [toView addGestureRecognizer:edgePanRecognizer];
    
    [UIView animateKeyframesWithDuration:self.transitionDuration
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
                                      fromView.alpha = 0;
                                      toView.alpha = 1;
                                  }];
                              } completion:^(BOOL finished) {
                                  if ([transitionContext transitionWasCancelled]) {
                                      [toView removeFromSuperview];
                                      [transitionContext completeTransition:NO];
                                  } else {
                                      [fromView removeFromSuperview];
                                      [transitionContext completeTransition:YES];
                                  }
                              }];
}

#pragma mark - edge back gesture handling

- (void) handleEdgePan:(UIScreenEdgePanGestureRecognizer *)gr
{
    CGPoint point = [gr translationInView:gr.view];
    
    switch (gr.state) {
        case UIGestureRecognizerStateBegan:
            self.interactive = YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat percent = point.x / gr.view.frame.size.width;
            self.shouldCompleteTransition = (percent > 0.25);
            
            [self updateInteractiveTransition: (percent <= 0.0) ? 0.0 : percent];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (!self.shouldCompleteTransition || gr.state == UIGestureRecognizerStateCancelled)
                [self cancelInteractiveTransition];
            else
                [self finishInteractiveTransition];
            self.interactive = NO;
            break;
        default:
            break;
    }
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (!navigationController) {
        return  nil;
    }
    
    if (![fromVC conformsToProtocol:@protocol(ZoomTransitionProtocol)] ||
        ![toVC conformsToProtocol:@protocol(ZoomTransitionProtocol)])
    {
        return nil;
    }
    
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (self.isInteractive) {
        return self;
    }
    
    return nil;
}

@end
