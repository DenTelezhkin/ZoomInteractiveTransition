//
//  KittenCell.h
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 29.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KittenCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *kittenImage;
@property (weak, nonatomic) IBOutlet UILabel *kittenName;

-(void)updateWithKitten:(NSString *)kitten;

@end
