//
//  QIMainViewController.h
//  socialspot
//
//  Created by Michal Jurník on 16/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QIPageContentViewController.h"
#import "QIPhotoContainerView.h"
#import "QIPhotoView.h"
#import "QIPhotoContainerViewController.h"
#import "QIEffectsViewController.h"

@interface QIMainViewController : QIPageContentViewController

@property (strong, nonatomic) QIPhotoViewController *draggedViewController;
@property (strong, nonatomic) IBOutlet QIPhotoContainerView *photoContainerView;
@property (strong, nonatomic) QIPhotoContainerViewController *photoContainerViewController;
@property (strong, nonatomic) QIEffectsViewController *effectsContainerViewController;
@property (strong, nonatomic) IBOutlet UIButton *photoButton;
@property (strong, nonatomic) IBOutlet UIButton *technologyButton;
@property (strong, nonatomic) IBOutlet UIButton *effectsButton;
@property (strong, nonatomic) IBOutlet UIView *photoAndTechnologyContainerView;
@property (strong, nonatomic) IBOutlet UIView *effectsContainerView;

- (IBAction)cancelTapped:(id)sender;

- (IBAction)photoTapped:(id)sender;
- (IBAction)technologyTapped:(id)sender;
- (IBAction)effectsTapped:(id)sender;

@end
