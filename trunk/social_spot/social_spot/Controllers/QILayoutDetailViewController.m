//
//  QILayoutDetailViewController.m
//  social_spot
//
//  Created by Michal Jurník on 15/07/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QILayoutDetailViewController.h"

@interface QILayoutDetailViewController ()

@end

@implementation QILayoutDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [self disableButtons];
    
    if ([[QIPictureManager sharedManager] selectedLayout] > 0) {
        UIView *view = [self.view viewWithTag:[[QIPictureManager sharedManager] selectedLayout]];
        view.layer.borderColor = RED_TEXT_COLOR.CGColor;
    }
    
    [self fillLayout];
}

- (void)createLayoutedPicture {
    if ([[QIPictureManager sharedManager] selectedLayout] == 1) {
        [[QIPictureManager sharedManager] setPicture:[[QIPictureManager sharedManager] imageWithView:_layoutView1]];
    }
    else {
        [[QIPictureManager sharedManager] setPicture:[[QIPictureManager sharedManager] imageWithView:_layoutView2]];
    }
}

- (void)disableButton:(UIButton *)button {
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.layer.borderWidth = 5;
}

- (IBAction)layoutButtonTapped:(UIButton *)sender {
    NSInteger tag = sender.tag;
    
    [[QIPictureManager sharedManager] setSelectedLayout:tag];
    [self createLayoutedPicture];
    [self disableButtons];
    sender.layer.borderColor = RED_TEXT_COLOR.CGColor;
}

- (void)disableButtons {
    UIButton *button1 = (UIButton *)[self.view viewWithTag:1];
    UIButton *button2 = (UIButton *)[self.view viewWithTag:2];
    UIButton *button3 = (UIButton *)[self.view viewWithTag:3];
    UIButton *button4 = (UIButton *)[self.view viewWithTag:4];
    
    if (button1) {
        [self disableButton:button1];
    }
    
    if (button2) {
        [self disableButton:button2];
    }
    
    if (button3) {
        [self disableButton:button3];
    }
    
    if (button4) {
        [self disableButton:button4];
    }
}

- (void)fillLayout {
    switch ([[[QIPictureManager sharedManager] selectedPictures] count]) {
        case 1:
            [self fillLayout1];
            break;
        case 2:
            [self fillLayout2];
            break;
        case 3:
            [self fillLayout3];
            break;
        case 4:
            [self fillLayout4];
            break;
        case 5:
            [self fillLayout5];
            break;
            
        default:
            break;
    }
}

- (void)fillLayout1 {
    [_picture1 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:0]];
}

- (void)fillLayout2 {
    [_picture1 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:0]];
    [_picture2 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:1]];
    [_picture3 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:0]];
    [_picture4 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:1]];
}

- (void)fillLayout3 {
    [_picture1 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:0]];
    [_picture2 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:1]];
    [_picture3 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:2]];
    [_picture4 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:0]];
    [_picture5 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:1]];
    [_picture6 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:2]];
}

- (void)fillLayout4 {
    [_picture1 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:0]];
    [_picture2 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:1]];
    [_picture3 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:2]];
    [_picture4 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:3]];
    [_picture5 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:0]];
    [_picture6 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:1]];
    [_picture7 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:2]];
    [_picture8 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:3]];
}

- (void)fillLayout5 {
    [_picture1 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:0]];
    [_picture2 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:1]];
    [_picture3 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:2]];
    [_picture4 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:3]];
    [_picture5 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:4]];
}

@end
