//
//  QIEffectsViewController.m
//  socialspot
//
//  Created by Michal Jurník on 23/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIEffectsViewController.h"

@interface QIEffectsViewController ()

@end

@implementation QIEffectsViewController

- (IBAction)frameButton1Tapped:(id)sender {
    _photoView.layer.borderWidth = 2.0;
}

- (IBAction)frameButton2Tapped:(id)sender {
    _photoView.layer.borderWidth = 4.0;

}

- (IBAction)frameButton3Tapped:(id)sender {
    _photoView.layer.borderWidth = 6.0;

}

@end
