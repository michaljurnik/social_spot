//
//  QIGalleryCollectionViewController.m
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIGalleryCollectionViewController.h"

@interface QIGalleryCollectionViewController ()

@end

@implementation QIGalleryCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[QIPictureManager sharedManager] pictures] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QIGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.pictureView setImage:[[[QIPictureManager sharedManager] pictures] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QIGalleryCell *cell = (QIGalleryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PICTURE_TAPPED object:nil userInfo:@{@"pictureIndexPath" : indexPath}];
}


@end
