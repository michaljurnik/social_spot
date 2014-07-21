//
//  QILayoutDetailViewController.h
//  social_spot
//
//  Created by Michal Jurník on 15/07/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QIPictureManager.h"

@interface QILayoutDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *picture1;
@property (nonatomic, strong) IBOutlet UIImageView *picture2;
@property (nonatomic, strong) IBOutlet UIImageView *picture3;
@property (nonatomic, strong) IBOutlet UIImageView *picture4;
@property (nonatomic, strong) IBOutlet UIImageView *picture5;
@property (nonatomic, strong) IBOutlet UIImageView *picture6;
@property (nonatomic, strong) IBOutlet UIImageView *picture7;
@property (nonatomic, strong) IBOutlet UIImageView *picture8;
@property (nonatomic, strong) IBOutlet UIView *layoutView1;
@property (nonatomic, strong) IBOutlet UIView *layoutView2;

- (IBAction)layoutButtonTapped:(UIButton *)sender;

@end
