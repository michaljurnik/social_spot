//
//  QILightboxViewController.m
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QILightboxViewController.h"

@interface QILightboxViewController ()

@end

@implementation QILightboxViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)hideTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LIGHTBOX_HIDE_TAPPED object:nil];
}

@end
