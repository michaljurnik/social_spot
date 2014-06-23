//
//  QIEffectsViewController.h
//  socialspot
//
//  Created by Michal Jurník on 23/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QILayoutPhotoViewController.h"

@interface QIEffectsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *photoView;

- (IBAction)frameButton1Tapped:(id)sender;
- (IBAction)frameButton2Tapped:(id)sender;
- (IBAction)frameButton3Tapped:(id)sender;

@end
