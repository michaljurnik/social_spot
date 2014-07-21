//
//  QIGalleryCollectionViewController.h
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QIPictureManager.h"
#import "QIGalleryCell.h"

@interface QIGalleryCollectionViewController : UICollectionViewController

@property (nonatomic, strong) IBOutlet UICollectionView *cv;
@property (nonatomic) NSIndexPath *scrollPath;

@end
