//
//  ZoomTransition.h
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 29.06.14.
//
//  Copyright (c) 2014 Denys Telezhkin
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "ZoomTransitionProtocol.h"

/**
 ZoomInteractiveTransition class allows to make interactive transition between two views. It is most commonly used with images, while transitioning from thumbnail image to big image.
 
 It can also serve as a UINavigationControllerDelegate to provide automatic transition handling.
 */

@interface ZoomInteractiveTransition : UIPercentDrivenInteractiveTransition <UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>

/**
 UINavigationController, that wants to participate in zoom transition
 */
@property (nonatomic, assign) UINavigationController * navigationController;

/**
 Zoom transition duration. Default value is 0.3 seconds.
 */
@property (nonatomic, assign) CGFloat transitionDuration;

/**
 If set to YES, UIScreenEdgePanGestureRecognizer will be automatically added to destinationView. It will allow interactive pop gesture. Default value is YES.
 */
@property (nonatomic, assign) BOOL handleEdgePanBackGesture;

/**
 Animation option for keyframe animations used to transition between views. Default value is UIViewKeyframeAnimationOptionCalculationModeCubic.
 */
@property (nonatomic, assign) UIViewKeyframeAnimationOptions transitionAnimationOption;


/**
 Designated initializer for ZoomInteractiveTransition. If created using this method, it will set itself as a delegate for UINavigationController.
 
 If you choose not to use it, you will need to implement UINavigationControllerDelegate methods for animated transitioning, and provide ZoomInteractiveTransition instance yourself.
 
 @param nc UINavigationController, that will use zoom animations
 
 @return ZoomInteractiveTransition instance.
 */
- (instancetype)initWithNavigationController:(UINavigationController *)nc;

/**
 *  Public method to reset the navigation controller's delegate
 */
- (void)resetDelegate;

@end
