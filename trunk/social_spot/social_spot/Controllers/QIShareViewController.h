//
//  QIShareViewController.h
//  socialspot
//
//  Created by Michal Jurník on 24/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "QIPageContentViewController.h"
#import "QIPictureManager.h"



@interface QIShareViewController : QIPageContentViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *footerLabel;
@property (strong, nonatomic) IBOutlet UIButton *facebookTextButton;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

- (IBAction)facebookButtonTapped:(id)sender;
- (IBAction)cancelButtonTapped:(id)sender;

@end
