//
//  QIPageViewController.h
//  socialspot
//
//  Created by Michal Jurník on 20/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QIIntroViewController.h"
#import "QIGalleryViewController.h"
#import "QILayoutViewController.h"
#import "QIShareViewController.h"

@interface QIPageContainerViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *controllers;

@end
