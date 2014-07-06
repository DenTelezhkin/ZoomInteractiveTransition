//
//  ZoomTransition.m
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 29.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import "ZoomInteractiveTransition.h"
#import "UIView+Snapshotting.h"

@interface ZoomInteractiveTransition()

@property (nonatomic, assign) CGFloat startScale;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, assign) BOOL shouldCompleteTransition;
@property (nonatomic, assign, getter = isInteractive) BOOL interactive;

@end

@implementation ZoomInteractiveTransition

-(void)commonSetup
{
    self.transitionDuration = 0.3;
    self.handleEdgePanBackGesture = YES;
    self.transitionAnimationOption = UIViewKeyframeAnimationOptionCalculationModeCubic;
}

- (instancetype)initWithNavigationController:(UINavigationController *)nc
{
    if (self = [super init]) {
        self.navigationController = nc;
        nc.delegate = self;
        [self commonSetup];
    }
    return self;
}

-(instancetype)init
{
    if (self = [super init])
    {
        [self commonSetup];
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.transitionDuration;
}

-(UIImageView *)initialZoomSnapshotFromView:(UIView *)sourceView
                            destinationView:(UIView *)destinationView
{
    
    UIImage * fromSnapshot = [sourceView dt_takeSnapshot];
    UIImage * toSnapshot = [destinationView dt_takeSnapshot];
    
    UIImage * animateSnapshot = toSnapshot;
    if (fromSnapshot.size.width>toSnapshot.size.width)
    {
        animateSnapshot = fromSnapshot;
    }
    UIImageView * sourceImageView = [[UIImageView alloc] initWithImage:animateSnapshot];
    sourceImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return sourceImageView;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController <ZoomTransitionProtocol> * fromVC = (id)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <ZoomTransitionProtocol> *toVC = (id)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = [fromVC view];
    UIView * toView = [toVC view];
    
    [containerView addSubview:toView];
    
    UIView * zoomFromView = [fromVC viewForZoomTransition];
    UIView * zoomToView = [toVC viewForZoomTransition];
    
    UIImageView * animatingImageView = [self initialZoomSnapshotFromView:zoomFromView
                                                         destinationView:zoomToView];
    
    if ([fromVC respondsToSelector:@selector(initialZoomViewSnapshotFromProposedSnapshot:)])
    {
        animatingImageView = [fromVC initialZoomViewSnapshotFromProposedSnapshot:animatingImageView];
    }
    
    animatingImageView.frame = [zoomFromView.superview convertRect:zoomFromView.frame
                                                            toView:containerView];
    
    fromView.alpha = 1;
    toView.alpha = 0;
    zoomFromView.alpha = 0;
    zoomToView.alpha = 0;
    [containerView addSubview:animatingImageView];
    
    if (self.handleEdgePanBackGesture)
    {
        UIScreenEdgePanGestureRecognizer *edgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                                action:@selector(handleEdgePan:)];
        edgePanRecognizer.edges = UIRectEdgeLeft;
        [toView addGestureRecognizer:edgePanRecognizer];
    }
    
    ZoomAnimationBlock animationBlock = nil;
    if ([fromVC respondsToSelector:@selector(animationBlockForZoomTransition)])
    {
        animationBlock = [fromVC animationBlockForZoomTransition];
    }
    
    [UIView animateKeyframesWithDuration:self.transitionDuration
                                   delay:0
                                 options:self.transitionAnimationOption
                              animations:^{
                                  animatingImageView.frame = [zoomToView.superview convertRect:zoomToView.frame toView:containerView];
                                  fromView.alpha = 0;
                                  toView.alpha = 1;
                                  
                                  if (animationBlock)
                                  {
                                      animationBlock(animatingImageView,zoomFromView,zoomToView);
                                  }
                              } completion:^(BOOL finished) {
                                  if ([transitionContext transitionWasCancelled]) {
                                      [toView removeFromSuperview];
                                      [transitionContext completeTransition:NO];
                                      zoomFromView.alpha = 1;
                                  } else {
                                      [fromView removeFromSuperview];
                                      [transitionContext completeTransition:YES];
                                      zoomToView.alpha = 1;
                                  }
                                  [animatingImageView removeFromSuperview];
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
