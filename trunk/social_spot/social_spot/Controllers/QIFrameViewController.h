//
//  QIFrameViewController.h
//  social_spot
//
//  Created by Michal Jurník on 27/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QIPictureManager.h"

@interface QIFrameViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, strong) IBOutlet UIImageView *frameView1;
@property (nonatomic, strong) IBOutlet UIImageView *frameView2;
@property (nonatomic, strong) IBOutlet UIImageView *frameView3;
@property (nonatomic, strong) IBOutlet UIImageView *frameView4;
@property (nonatomic, strong) IBOutlet UIImageView *frameView5;
@property (nonatomic, strong) IBOutlet UIImageView *frameView6;

- (IBAction)previewButtonTapped:(id)sender;
- (IBAction)nextButtonTapped:(id)sender;
- (IBAction)frameButtonTapped:(UIButton *)sender;

@end
