//
//  QILayoutPhotoViewController.m
//  socialspot
//
//  Created by Michal Jurník on 23/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QILayoutPhotoViewController.h"

@interface QILayoutPhotoViewController ()

@end

@implementation QILayoutPhotoViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.view setBackgroundColor:COLOR_LAYOUT_BACKGROUND];
    
    if (!_imageView2) _imageView2 = [[UIImageView alloc] init];
    if (!_imageView3) _imageView3 = [[UIImageView alloc] init];
    if (!_imageView4) _imageView4 = [[UIImageView alloc] init];
    if (!_imageView5) _imageView5 = [[UIImageView alloc] init];
}

@end
