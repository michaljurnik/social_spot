//
//  QIPhotoContainerViewController.h
//  socialspot
//
//  Created by Michal Jurník on 20/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QIPhotoViewController.h"
#import "QILayoutPhotoViewController.h"

@interface QIPhotoContainerViewController : UIViewController

@property (strong, nonatomic) QIPhotoViewController *draggedViewController;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *imageGroups;
@property (strong, nonatomic) NSMutableArray *imageControllers;
@property (atomic) NSUInteger index;
@property (strong, nonatomic) QILayoutPhotoViewController *layoutViewController;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) IBOutlet UIButton *layoutButton1;
@property (strong, nonatomic) IBOutlet UIButton *layoutButton2;
@property (strong, nonatomic) IBOutlet UIButton *layoutButton3;
@property (strong, nonatomic) IBOutlet UIButton *layoutButton4;
@property (strong, nonatomic) IBOutlet UIButton *layoutButton5;
@property (strong, nonatomic) IBOutlet UIButton *layoutButton6;
@property (strong, nonatomic) QILayoutPhotoViewController *layoutViewController1;
@property (strong, nonatomic) QILayoutPhotoViewController *layoutViewController2;
@property (strong, nonatomic) QILayoutPhotoViewController *layoutViewController3;
@property (strong, nonatomic) QILayoutPhotoViewController *layoutViewController4;
@property (strong, nonatomic) QILayoutPhotoViewController *layoutViewController5;
@property (strong, nonatomic) QILayoutPhotoViewController *layoutViewController6;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer1;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer2;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer3;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer4;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer5;
@property (strong, nonatomic) IBOutlet UIView *layoutContainer6;

- (void)changeTab:(NSUInteger)index;
- (IBAction)leftButtonTapped:(id)sender;
- (IBAction)rightButtonTapped:(id)sender;
- (IBAction)handlePan:(id)sender;
- (IBAction)layoutButtonTapped:(id)sender;

@end
