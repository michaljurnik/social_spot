//
//  QIFrameViewController.m
//  social_spot
//
//  Created by Michal Jurník on 27/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIFrameViewController.h"

@interface QIFrameViewController ()

@end

@implementation QIFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:46.0]];
    
    [_nextButton.titleLabel setFont:FONT_BUTTON];
    [_previousButton.titleLabel setFont:FONT_BUTTON];
}

- (void)viewWillAppear:(BOOL)animated {
    [self disableButtons];
    
    if ([[QIPictureManager sharedManager] selectedFrame] > 0) {
        UIView *view = [self.view viewWithTag:[[QIPictureManager sharedManager] selectedFrame]];
        view.layer.borderColor = RED_TEXT_COLOR.CGColor;
    }
    
    [self fillFrames];
    [self localizeTexts];
}

- (void)fillFrames {
    [_frameView1 setImage:[[QIPictureManager sharedManager] picture]];
    [_frameView2 setImage:[[QIPictureManager sharedManager] picture]];
    [_frameView3 setImage:[[QIPictureManager sharedManager] picture]];
    [_frameView4 setImage:[[QIPictureManager sharedManager] picture]];
    [_frameView5 setImage:[[QIPictureManager sharedManager] picture]];
    [_frameView6 setImage:[[QIPictureManager sharedManager] picture]];
}

- (IBAction)previewButtonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PREVIOUS_PAGE object:nil];
}

- (IBAction)nextButtonTapped:(id)sender {
    if ([[QIPictureManager sharedManager] selectedFrame] > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NEXT_PAGE object:nil];
    }
    else {
        if ([[QIPictureManager sharedManager] languageID] == 2) {
            [[[UIAlertView alloc] initWithTitle:@"Rámeček" message:@"Musíte vybrat rámeček obrázku" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else if ([[QIPictureManager sharedManager] languageID] == 3) {
            [[[UIAlertView alloc] initWithTitle:@"Bilder-Rahmen" message:@"Sie müssen Bilder-Rahmen wählen" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"Picture's frame" message:@"You must choose picture's frame" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}

- (IBAction)frameButtonTapped:(UIButton *)sender {
    NSInteger tag = sender.tag;
    
    [[QIPictureManager sharedManager] setSelectedFrame:tag];
    [self disableButtons];
    sender.layer.borderColor = RED_TEXT_COLOR.CGColor;
}

- (void)disableButton:(UIButton *)button {
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.layer.borderWidth = 5;
}

- (void)disableButtons {
    UIButton *button1 = (UIButton *)[self.view viewWithTag:1];
    UIButton *button2 = (UIButton *)[self.view viewWithTag:2];
    UIButton *button3 = (UIButton *)[self.view viewWithTag:3];
    UIButton *button4 = (UIButton *)[self.view viewWithTag:4];
    UIButton *button5 = (UIButton *)[self.view viewWithTag:5];
    UIButton *button6 = (UIButton *)[self.view viewWithTag:6];
    
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
    
    if (button5) {
        [self disableButton:button5];
    }
    
    if (button6) {
        [self disableButton:button6];
    }
}

- (void)localizeTexts {
    if ([[QIPictureManager sharedManager] languageID] == 2) {
        _titleLabel.text = @"Vyberte rámeček";
        
        [_previousButton setTitle:@"Zpět" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Zpět" forState:UIControlStateSelected];
        [_nextButton setTitle:@"Další" forState:UIControlStateNormal];
        [_nextButton setTitle:@"Další" forState:UIControlStateSelected];
    }
    else if ([[QIPictureManager sharedManager] languageID] == 3) {
        _titleLabel.text = @"Wählen Sie Rahmen";
        
        [_previousButton setTitle:@"Zurück" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Zurück" forState:UIControlStateSelected];
        [_nextButton setTitle:@"Nächste" forState:UIControlStateNormal];
        [_nextButton setTitle:@"Nächste" forState:UIControlStateSelected];
    }
    else {
        _titleLabel.text = @"Choose frame";
        
        [_previousButton setTitle:@"Previous" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Previous" forState:UIControlStateSelected];
        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [_nextButton setTitle:@"Next" forState:UIControlStateSelected];
    }
}

@end
