//
//  QIPictureManager.h
//  socialspot
//
//  Created by Michal Jurník on 24/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QIPictureManager : NSObject

@property (nonatomic, readwrite) NSInteger languageID;
@property (nonatomic, strong) UIImage *picture;
@property (nonatomic, strong) NSArray *pictures;
@property (nonatomic, strong) NSMutableArray *selectedPictures;
@property (nonatomic, readwrite) NSInteger selectedLayout;
@property (nonatomic, readwrite) NSInteger selectedFrame;

+ (QIPictureManager *)sharedManager;

- (UIImage *)imageWithView:(UIView *)view;

- (void)picutreTapped:(NSIndexPath *)indexPath;
- (void)addSelectedPictures:(NSIndexPath *)indexPath;
- (BOOL)removeSelectedPictures:(NSIndexPath *)indexPath;
- (void)removeAllSelectedData;

@end
