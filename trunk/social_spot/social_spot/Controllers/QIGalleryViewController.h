//
//  QIGalleryViewController.h
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QILightboxContainerView.h"
#import "QIPictureManager.h"
#import "QIGAlleryCell.h"


@interface QIGalleryViewController : UIViewController

@property (strong, nonatomic) IBOutlet QILightboxContainerView *lightboxContainerView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *selectButton;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (readwrite, atomic) BOOL isSelectMode;

- (IBAction)previewButtonTapped:(id)sender;
- (IBAction)nextButtonTapped:(id)sender;
- (IBAction)selectButtonTapped:(id)sender;
- (IBAction)doneButtonTapped:(id)sender;
- (IBAction)scrollBackButtonTapped:(id)sender;
- (IBAction)scrollNextkButtonTapped:(id)sender;

@end

