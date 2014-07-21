//
//  QIIntroViewController.h
//  socialspot
//
//  Created by Michal Jurník on 20/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIPageContentViewController.h"
#import "QIPictureManager.h"

@interface QIIntroViewController : QIPageContentViewController

@property (strong, nonatomic) IBOutlet UIButton *engButton;
@property (strong, nonatomic) IBOutlet UIButton *czButton;
@property (strong, nonatomic) IBOutlet UIButton *gerButton;
@property (strong, nonatomic) IBOutlet UILabel *subtitle;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *footerLabel;

- (IBAction)takeAPhotoTapped:(id)sender;
- (IBAction)languageButtonTapped:(id)sender;

@end
