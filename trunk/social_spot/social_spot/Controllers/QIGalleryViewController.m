//
//  QIGalleryViewController.m
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIGalleryViewController.h"

@interface QIGalleryViewController ()

@end

@implementation QIGalleryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isSelectMode = NO;
    [_titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:46.0]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureTapped:) name:NOTIFICATION_PICTURE_TAPPED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideLightboxTapped:) name:NOTIFICATION_LIGHTBOX_HIDE_TAPPED object:nil];
    
    [_doneButton.titleLabel setFont:FONT_BUTTON];
    [_selectButton.titleLabel setFont:FONT_BUTTON];
    [_nextButton.titleLabel setFont:FONT_BUTTON];
    [_previousButton.titleLabel setFont:FONT_BUTTON];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self localizeTexts];
}

- (void)pictureTapped:(NSNotification *)notification {
    if (_isSelectMode) {
        QIGalleryCell *cell = (QIGalleryCell *)[notification.userInfo objectForKey:@"pictureCell"];
        
        if ([[[QIPictureManager sharedManager] selectedPictures] count] < 5 || [cell isSelected]) {
            [[QIPictureManager sharedManager] setSelectedLayout:0];
            [[QIPictureManager sharedManager] setSelectedFrame:0];
            [cell changeIsSelected];
            [[QIPictureManager sharedManager] picutreTapped:[notification.userInfo objectForKey:@"pictureIndexPath"]];
        }
        else {
            if ([[QIPictureManager sharedManager] languageID] == 2) {
                [[[UIAlertView alloc] initWithTitle:@"Počet fotek" message:@"Nemůžete vybrat více jak 5 fotek" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
            else if ([[QIPictureManager sharedManager] languageID] == 3) {
                [[[UIAlertView alloc] initWithTitle:@"Bild Zahl" message:@"Sie können nicht mehr als 5 Bilder auswählen" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
            else {
                [[[UIAlertView alloc] initWithTitle:@"Picture count" message:@"You can't select more than 5 pictures" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
        }
    }
    else {
        [_lightboxContainerView show];
    }
}

- (void)hideLightboxTapped:(NSNotification *)notification {
    [_lightboxContainerView hide];
}

- (IBAction)previewButtonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PREVIOUS_PAGE object:nil];
}

- (IBAction)nextButtonTapped:(id)sender {
    if ([[[QIPictureManager sharedManager] selectedPictures] count] > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NEXT_PAGE object:nil];
    }
    else {
        if ([[QIPictureManager sharedManager] languageID] == 2) {
            [[[UIAlertView alloc] initWithTitle:@"Počet fotek" message:@"Musíte vybrat alespoň jednu fotku" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else if ([[QIPictureManager sharedManager] languageID] == 3) {
            [[[UIAlertView alloc] initWithTitle:@"Bild Zahl" message:@"Sie müssen mindestens ein Bild auswählen" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"Picture count" message:@"You must choose at least one picture" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}

- (IBAction)scrollBackButtonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SCROLL_BACK object:nil];
}

- (IBAction)scrollNextkButtonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SCROLL_NEXT object:nil];
}

- (IBAction)selectButtonTapped:(id)sender {
    _isSelectMode = YES;
    [_selectButton setHidden:YES];
    [_doneButton setHidden:NO];
}

- (IBAction)doneButtonTapped:(id)sender {
    _isSelectMode = NO;
    [_selectButton setHidden:NO];
    [_doneButton setHidden:YES];
}

- (void)localizeTexts {
    if ([[QIPictureManager sharedManager] languageID] == 2) {
        _titleLabel.text = @"Vyberte obrázky";
        
        [_doneButton setTitle:@"Hotovo" forState:UIControlStateNormal];
        [_doneButton setTitle:@"Hotovo" forState:UIControlStateSelected];
        [_selectButton setTitle:@"Vybrat" forState:UIControlStateNormal];
        [_selectButton setTitle:@"Vybrat" forState:UIControlStateSelected];
        [_previousButton setTitle:@"Zpět" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Zpět" forState:UIControlStateSelected];
        [_nextButton setTitle:@"Další" forState:UIControlStateNormal];
        [_nextButton setTitle:@"Další" forState:UIControlStateSelected];
    }
    else if ([[QIPictureManager sharedManager] languageID] == 3) {
        _titleLabel.text = @"Wählen Sie Bilder";
        [_doneButton setTitle:@"Fertig" forState:UIControlStateNormal];
        [_doneButton setTitle:@"Fertig" forState:UIControlStateSelected];
        [_selectButton setTitle:@"Wählen" forState:UIControlStateNormal];
        [_selectButton setTitle:@"Wählen" forState:UIControlStateSelected];
        [_previousButton setTitle:@"Zurück" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Zurück" forState:UIControlStateSelected];
        [_nextButton setTitle:@"Nächste" forState:UIControlStateNormal];
        [_nextButton setTitle:@"Nächste" forState:UIControlStateSelected];
    }
    else {
        _titleLabel.text = @"Choose pictures";
        
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [_doneButton setTitle:@"Done" forState:UIControlStateSelected];
        [_selectButton setTitle:@"Select" forState:UIControlStateNormal];
        [_selectButton setTitle:@"Select" forState:UIControlStateSelected];
        [_previousButton setTitle:@"Previous" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Previous" forState:UIControlStateSelected];
        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [_nextButton setTitle:@"Next" forState:UIControlStateSelected];
    }
}

@end
