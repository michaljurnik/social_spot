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


- (IBAction)takeAPhotoTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NEXT_PAGE object:nil];
}

@end
