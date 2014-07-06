//
//  KittenCollectionViewController.m
//  ZoomSegueExample
//
//  Created by Denys Telezhkin on 29.06.14.
//  Copyright (c) 2014 Denys Telezhkin. All rights reserved.
//

#import "KittenCollectionViewController.h"
#import "PlaceKit.h"
#import "KittenCell.h"
#import "KittenDetailViewController.h"
#import "ZoomInteractiveTransition.h"
#import "ZoomTransitionProtocol.h"

@interface KittenCollectionViewController () <ZoomTransitionProtocol>

@property (nonatomic, strong) NSArray * names;
@property (nonatomic, strong) ZoomInteractiveTransition * transition;
@property (nonatomic, strong) NSIndexPath * selectedIndexPath;

@end

@implementation KittenCollectionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.names = [self kittensArrayOfSize:50];
    self.transition = [[ZoomInteractiveTransition alloc] initWithNavigationController:self.navigationController];
}

-(NSArray *)kittensArrayOfSize:(NSInteger)size
{
    NSMutableArray * kittensArray = [NSMutableArray arrayWithCapacity:size];
    for (int i=0;i<size;i++)
    {
        [kittensArray addObject:[PlaceKit placeRandomFirstName]];
    }
    return kittensArray;
}

#pragma mark - segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"toKittenDetailViewController"])
    {
        KittenDetailViewController * dvc = segue.destinationViewController;
        self.selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        KittenCell * selectedCell = (KittenCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
        dvc.kittenImage = selectedCell.kittenImage.image;
        dvc.gestureTarget = self.transition;
    }
}

#pragma mark - UICollectionViewDatasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.names count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KittenCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KittenCell class])
                                                                  forIndexPath:indexPath];
    [cell updateWithKitten:self.names[indexPath.row]];
    return cell;
}

#pragma mark - ZoomTransitionProtocol

-(UIView *)viewForZoomTransition
{
    KittenCell * cell = (KittenCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
    return cell.kittenImage;
}

@end
