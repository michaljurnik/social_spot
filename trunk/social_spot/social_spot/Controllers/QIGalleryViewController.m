//
//  QIGalleryViewController.m
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIGalleryViewController.h"

@interface QIGalleryViewController ()

@end

@implementation QIGalleryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureTapped:) name:NOTIFICATION_PICTURE_TAPPED object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideLightboxTapped:) name:NOTIFICATION_LIGHTBOX_HIDE_TAPPED object:nil];
}

- (void)pictureTapped:(NSNotification *)notification {
    [_lightboxContainerView show];
}

- (void)hideLightboxTapped:(NSNotification *)notification {
    [_lightboxContainerView hide];
}

@end
