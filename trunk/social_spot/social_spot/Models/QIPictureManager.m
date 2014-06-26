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
    }
    
    return self;
}

- (void)loadPictures {
    _pictures = @[[UIImage imageNamed:@"1.png"],
                  [UIImage imageNamed:@"2.png"],
                  [UIImage imageNamed:@"3.png"],
                  [UIImage imageNamed:@"4.png"],
                  [UIImage imageNamed:@"5.png"],
                  [UIImage imageNamed:@"6.png"],
                  [UIImage imageNamed:@"7.png"],
                  [UIImage imageNamed:@"1.png"],
                  [UIImage imageNamed:@"2.png"],
                  [UIImage imageNamed:@"3.png"],
                  [UIImage imageNamed:@"4.png"],
                  [UIImage imageNamed:@"5.png"],
                  [UIImage imageNamed:@"6.png"],
                  [UIImage imageNamed:@"7.png"],
                  [UIImage imageNamed:@"1.png"],
                  [UIImage imageNamed:@"2.png"],
                  [UIImage imageNamed:@"3.png"],
                  [UIImage imageNamed:@"4.png"],
                  [UIImage imageNamed:@"5.png"],
                  [UIImage imageNamed:@"6.png"],
                  [UIImage imageNamed:@"7.png"]];
}

- (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    _picture = img;
    
    return img;
}

@end
