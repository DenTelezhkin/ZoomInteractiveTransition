//
//  KittenDetailViewController.m
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 29.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import "KittenDetailViewController.h"
#import "ZoomTransitionProtocol.h"

@interface KittenDetailViewController () <ZoomTransitionProtocol>

@property (weak, nonatomic) IBOutlet UIImageView *kittenImageView;

@end

@implementation KittenDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.kittenImageView setImage:self.kittenImage];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self.gestureTarget action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchRecognizer];
}

#pragma mark - ZoomTransitionProtocol

-(UIView *)viewForZoomTransition
{
    return self.kittenImageView;
}

@end
