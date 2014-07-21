//
//  QIIntroViewController.m
//  socialspot
//
//  Created by Michal Jurník on 20/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIIntroViewController.h"


@interface QIIntroViewController ()

@end

@implementation QIIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:80.0]];
    [_subtitle setFont:[UIFont fontWithName:@"Roboto-Light" size:30.0]];
    [_footerLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:16.0]];
    
    [self reloadLanguageButtons];
    [self localizeTexts];
}

- (IBAction)takeAPhotoTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NEXT_PAGE object:nil];
}

- (IBAction)languageButtonTapped:(id)sender {
    
    if ([sender isEqual:_czButton]) {
        [_czButton setSelected:YES];
        [[QIPictureManager sharedManager] setLanguageID:2];
    }
    else if ([sender isEqual:_gerButton]) {
        [_gerButton setSelected:YES];
        [[QIPictureManager sharedManager] setLanguageID:3];
    }
    else {
        [_engButton setSelected:YES];
        [[QIPictureManager sharedManager] setLanguageID:1];
    }
    
    [self reloadLanguageButtons];
    [self localizeTexts];
}

- (void)reloadLanguageButtons {
    [_engButton setSelected:NO];
    [_czButton setSelected:NO];
    [_gerButton setSelected:NO];
    
    if ([[QIPictureManager sharedManager] languageID] == 2) {
        [_czButton setSelected:YES];
    
    }
    else if ([[QIPictureManager sharedManager] languageID] == 3) {
        [_gerButton setSelected:YES];
    }
    else {
        [_engButton setSelected:YES];
    }
}

- (void)localizeTexts {
    if ([[QIPictureManager sharedManager] languageID] == 2) {
        _titleLabel.text = @"Vybrat obrázek";
        _subtitle.text = @"Sdílej svůj zážitek:";
        _footerLabel.text = @"SocialSpot vytvořen společností Quanti s.r.o.";
    }
    else if ([[QIPictureManager sharedManager] languageID] == 3) {
        _titleLabel.text = @"Wählen Sie ein Bild";
        _subtitle.text = @"Teilen Sie Ihre Erfahrungen:";
        _footerLabel.text = @"SocialSpot durch die Quanti s.r.o. erstellt";
    }
    else {
        _titleLabel.text = @"Take a picture";
        _subtitle.text = @"Share your experience:";
        _footerLabel.text = @"SocialSpot powered by Quanti s.r.o.";
    }
}

@end
