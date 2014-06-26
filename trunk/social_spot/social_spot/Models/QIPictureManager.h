//
//  QIPictureManager.h
//  socialspot
//
//  Created by Michal Jurník on 24/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QIPictureManager : NSObject

@property (nonatomic, strong) UIImage *picture;
@property (nonatomic, strong) NSArray *pictures;

+ (QIPictureManager *)sharedManager;

- (UIImage *)imageWithView:(UIView *)view;

@end
