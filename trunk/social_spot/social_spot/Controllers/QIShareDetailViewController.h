//
//  QIShareDetailViewController.h
//  social_spot
//
//  Created by Michal Jurník on 18/07/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QIPictureManager.h"

@interface QIShareDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *frameView;
@property (nonatomic, strong) IBOutlet UIImageView *picture1;
@property (nonatomic, strong) IBOutlet UIImageView *picture2;
@property (nonatomic, strong) IBOutlet UIImageView *picture3;
@property (nonatomic, strong) IBOutlet UIImageView *picture4;
@property (nonatomic, strong) IBOutlet UIImageView *picture5;

- (void)fillPictures;
- (void)fillFrame;

@end
