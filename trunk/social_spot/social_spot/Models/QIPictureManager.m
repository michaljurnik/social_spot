//
//  QIPictureManager.m
//  socialspot
//
//  Created by Michal Jurník on 24/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIPictureManager.h"

@implementation QIPictureManager

static QIPictureManager *sharedManager = nil;

+ (QIPictureManager *)sharedManager {
    if (nil != sharedManager) {
        return sharedManager;
    }
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedManager = [[QIPictureManager alloc] init];
    });
    
    return sharedManager;
}

- (QIPictureManager *)init {
    self = [super init];
    
    if (self) {
        [self loadPictures];
        _selectedPictures = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return self;
}

- (void)loadPictures {
    _pictures = @[[UIImage imageNamed:@"1.jpg"],
                  [UIImage imageNamed:@"2.jpg"],
                  [UIImage imageNamed:@"3.jpg"],
                  [UIImage imageNamed:@"4.jpg"],
                  [UIImage imageNamed:@"5.jpg"],
                  [UIImage imageNamed:@"6.jpg"],
                  [UIImage imageNamed:@"7.jpg"],
                  [UIImage imageNamed:@"8.jpg"],
                  [UIImage imageNamed:@"9.jpg"],
                  [UIImage imageNamed:@"10.jpg"],
                  [UIImage imageNamed:@"11.jpg"],
                  [UIImage imageNamed:@"12.jpg"],
                  [UIImage imageNamed:@"13.jpg"],
                  [UIImage imageNamed:@"14.jpg"],
                  [UIImage imageNamed:@"15.jpg"],
                  [UIImage imageNamed:@"16.jpg"],
                  [UIImage imageNamed:@"17.jpg"]];
}

- (void)picutreTapped:(NSIndexPath *)indexPath {
    if (![self removeSelectedPictures:indexPath]) {
        [self addSelectedPictures:indexPath];
    }
}

- (void)addSelectedPictures:(NSIndexPath *)indexPath {
    [_selectedPictures addObject:[_pictures objectAtIndex:indexPath.row]];
}

- (BOOL)removeSelectedPictures:(NSIndexPath *)indexPath {
    UIImage *selectedImage = [_pictures objectAtIndex:indexPath.row];
    
    for (UIImage *image in _selectedPictures) {
        if ([image isEqual:selectedImage]) {
            [_selectedPictures removeObject:image];
            
            return YES;
        }
    }
    
    return NO;
}

- (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    _picture = img;
    
    return img;
}

- (void)removeAllSelectedData {
    [_selectedPictures removeAllObjects];
    _selectedFrame = 0;
    _selectedLayout = 0;
    _languageID = 1;
}

@end
