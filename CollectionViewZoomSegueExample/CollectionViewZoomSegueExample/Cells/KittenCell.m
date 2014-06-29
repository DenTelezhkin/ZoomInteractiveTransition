//
//  KittenCell.m
//  CollectionViewZoomSegueExample
//
//  Created by Denys Telezhkin on 29.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import "KittenCell.h"
#import "PlaceKit.h"

@implementation KittenCell

-(void)updateWithKitten:(NSString *)kitten
{
    self.kittenName.text = kitten;
    
    [PlaceKit placeRandomImageWithSize:CGSizeMake(320, 320)
                              category:@"cats"
                            completion:^(UIImage *randomImage) {
                                [self.kittenImage setImage:randomImage];
                            }];
}

@end
