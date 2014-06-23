//
//  QIMainViewController.m
//  socialspot
//
//  Created by Michal Jurník on 16/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIMainViewController.h"

@interface QIMainViewController ()

@end

@implementation QIMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)cancelTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PREVIOUS_PAGE object:nil];
}

- (IBAction)photoTapped:(id)sender {
    [self clearMenuAllButtons];
    UIButton *button = (UIButton *)sender;
    [button setTitleColor:RED_TEXT_COLOR forState:UIControlStateNormal];
    [button setBackgroundColor:LIGHT_GRAY_MENU_COLOR];
    [_effectsContainerView setHidden:YES];
    [_photoAndTechnologyContainerView setHidden:NO];
    [_photoContainerViewController changeTab:0];
}

- (IBAction)technologyTapped:(id)sender {
    [self clearMenuAllButtons];
    UIButton *button = (UIButton *)sender;
    [button setTitleColor:RED_TEXT_COLOR forState:UIControlStateNormal];
    [button setBackgroundColor:LIGHT_GRAY_MENU_COLOR];
    [_effectsContainerView setHidden:YES];
    [_photoAndTechnologyContainerView setHidden:NO];
    [_photoContainerViewController changeTab:1];
}

- (IBAction)effectsTapped:(id)sender {
    [self clearMenuAllButtons];
    UIButton *button = (UIButton *)sender;
    [button setTitleColor:RED_TEXT_COLOR forState:UIControlStateNormal];
    [button setBackgroundColor:LIGHT_GRAY_MENU_COLOR];
    [_effectsContainerView setHidden:NO];
    [_photoAndTechnologyContainerView setHidden:YES];
    [_effectsContainerViewController.photoView setImage:[QIMainViewController imageWithView:_photoContainerViewController.layoutViewController.view]];
}

+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - Segues

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString:SEGUE_PHOTO_CONTAINER_VIEW_CONTROLLER]) {
        _photoContainerViewController = (QIPhotoContainerViewController *) [segue destinationViewController];
    }
    
    if ([segueName isEqualToString:SEGUE_EFFECTS_CONTAINER_VIEW_CONTROLLER]) {
        _effectsContainerViewController = (QIEffectsViewController *) [segue destinationViewController];
    }
}

#pragma mark - Helpers

- (void)clearMenuAllButtons {
    [_photoButton setBackgroundColor:DARK_GRAY_MENU_COLOR];
    [_technologyButton setBackgroundColor:DARK_GRAY_MENU_COLOR];
    [_effectsButton setBackgroundColor:DARK_GRAY_MENU_COLOR];
    [_photoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_technologyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_effectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
