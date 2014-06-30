//
//  ZoomTransitionProtocol.h
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 30.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoomTransition.h"

@protocol ZoomTransitionProtocol <NSObject>

-(UIView *)viewForZoomTransition:(ZoomTransition *)transition;

@end
