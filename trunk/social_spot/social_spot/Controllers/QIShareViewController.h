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
#import "QIShareDetailViewController.h"
#import "QILoadingView.h"


@interface QIShareViewController : QIPageContentViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *facebookTextButton;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIView *container1;
@property (strong, nonatomic) IBOutlet UIView *container2;
@property (strong, nonatomic) IBOutlet UIView *container3;
@property (strong, nonatomic) IBOutlet UIView *container4;
@property (strong, nonatomic) IBOutlet UIView *container5;
@property (strong, nonatomic) IBOutlet UIView *container6;
@property (strong, nonatomic) IBOutlet UIView *container7;
@property (strong, nonatomic) IBOutlet UIView *container8;
@property (strong, nonatomic) IBOutlet QIShareDetailViewController *detailViewController1;
@property (strong, nonatomic) IBOutlet QIShareDetailViewController *detailViewController2;
@property (strong, nonatomic) IBOutlet QIShareDetailViewController *detailViewController3;
@property (strong, nonatomic) IBOutlet QIShareDetailViewController *detailViewController4;
@property (strong, nonatomic) IBOutlet QIShareDetailViewController *detailViewController5;
@property (strong, nonatomic) IBOutlet QIShareDetailViewController *detailViewController6;
@property (strong, nonatomic) IBOutlet QIShareDetailViewController *detailViewController7;
@property (strong, nonatomic) IBOutlet QIShareDetailViewController *detailViewController8;

- (IBAction)facebookButtonTapped:(id)sender;
- (IBAction)previewButtonTapped:(id)sender;

@end
