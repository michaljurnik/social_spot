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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollBack) name:NOTIFICATION_SCROLL_BACK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollNext) name:NOTIFICATION_SCROLL_NEXT object:nil];
    _scrollPath = [NSIndexPath indexPathForRow:1 inSection:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

- (void)scrollBack {
    float offsetX = self.collectionView.contentOffset.x - self.view.frame.size.width - 13;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)scrollNext {
    float offsetX = self.collectionView.contentOffset.x + self.view.frame.size.width + 13;
    
    if (offsetX <= self.collectionView.contentSize.width) {
        [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[QIPictureManager sharedManager] pictures] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QIGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImage *picture = [[[QIPictureManager sharedManager] pictures] objectAtIndex:indexPath.row];
    
    [cell.pictureView setImage:picture];
    [cell setIsSelected:NO];
    
    if ([[[QIPictureManager sharedManager] selectedPictures] count] > 0) {
        for (UIImage *selectedPicture in [[QIPictureManager sharedManager] selectedPictures]) {
            if ([picture isEqual:selectedPicture]) {
                [cell setIsSelected:YES];
            }
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QIGalleryCell *cell = (QIGalleryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSDictionary *userInfo = @{@"pictureIndexPath" : indexPath,
                               @"pictureCell" : cell};
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PICTURE_TAPPED object:nil userInfo:userInfo];
}

@end
