//
//  QIIntroViewController.m
//  socialspot
//
//  Created by Michal Jurník on 20/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIIntroViewController.h"

@interface QIIntroViewController ()

@end

@implementation QIIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:80.0]];
    [_subtitle setFont:[UIFont fontWithName:@"Roboto-Light" size:30.0]];
    [_footerLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:16.0]];
}

- (IBAction)takeAPhotoTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NEXT_PAGE object:nil];
}

@end
