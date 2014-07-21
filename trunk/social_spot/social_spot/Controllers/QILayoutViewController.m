//
//  QILayoutViewController.m
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QILayoutViewController.h"

@interface QILayoutViewController ()

@end

@implementation QILayoutViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:46.0]];
    [self hideLayoutContainers];
    
    [_nextButton.titleLabel setFont:FONT_BUTTON];
    [_previousButton.titleLabel setFont:FONT_BUTTON];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self localizeTexts];
    [self hideLayoutContainers];
    [self showLayoutContainer];
}

- (IBAction)previewButtonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PREVIOUS_PAGE object:nil];
}

- (IBAction)nextButtonTapped:(id)sender {
    if ([[QIPictureManager sharedManager] selectedLayout] > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NEXT_PAGE object:nil];
    }
    else {
        if ([[QIPictureManager sharedManager] languageID] == 2) {
            [[[UIAlertView alloc] initWithTitle:@"Šablona" message:@"Musíte vybrat šablonu" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else if ([[QIPictureManager sharedManager] languageID] == 3) {
            [[[UIAlertView alloc] initWithTitle:@"Bild Layout" message:@"Sie müssen Bild Layout wählen" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"Picture's layout" message:@"You must choose picture's layout" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}

- (void)showLayoutContainer {
    NSInteger pictureCount = [[[QIPictureManager sharedManager] selectedPictures] count];
    
    switch (pictureCount) {
        case 1:
            [_layoutContainer1 setHidden:NO];
            break;
        case 2:
            [_layoutContainer2 setHidden:NO];
            break;
        case 3:
            [_layoutContainer3 setHidden:NO];
            break;
        case 4:
            [_layoutContainer4 setHidden:NO];
            break;
        case 5:
            [_layoutContainer5 setHidden:NO];
            break;
        default:
            [_layoutContainer1 setHidden:NO];
            break;
    }
}

- (void)hideLayoutContainers {
    [_layoutContainer1 setHidden:YES];
    [_layoutContainer2 setHidden:YES];
    [_layoutContainer3 setHidden:YES];
    [_layoutContainer4 setHidden:YES];
    [_layoutContainer5 setHidden:YES];
}

- (void)localizeTexts {
    if ([[QIPictureManager sharedManager] languageID] == 2) {
        _titleLabel.text = @"Vyberte šablonu";
        
        [_previousButton setTitle:@"Zpět" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Zpět" forState:UIControlStateSelected];
        [_nextButton setTitle:@"Další" forState:UIControlStateNormal];
        [_nextButton setTitle:@"Další" forState:UIControlStateSelected];
    }
    else if ([[QIPictureManager sharedManager] languageID] == 3) {
        _titleLabel.text = @"Layout wählen";
        
        [_previousButton setTitle:@"Zurück" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Zurück" forState:UIControlStateSelected];
        [_nextButton setTitle:@"Nächste" forState:UIControlStateNormal];
        [_nextButton setTitle:@"Nächste" forState:UIControlStateSelected];
    }
    else {
        _titleLabel.text = @"Choose layout";
        
        [_previousButton setTitle:@"Previous" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Previous" forState:UIControlStateSelected];
        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [_nextButton setTitle:@"Next" forState:UIControlStateSelected];
    }
}



@end
