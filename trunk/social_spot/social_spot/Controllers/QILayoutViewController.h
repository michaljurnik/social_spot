//
//  QILayoutViewController.h
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QIPictureManager.h"

@interface QILayoutViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer1;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer2;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer3;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer4;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer5;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)previewButtonTapped:(id)sender;
- (IBAction)nextButtonTapped:(id)sender;

@end
