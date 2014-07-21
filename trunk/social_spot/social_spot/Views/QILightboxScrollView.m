//
//  QILightboxScrollView.m
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QILightboxScrollView.h"

@implementation QILightboxScrollView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureTapped:) name:NOTIFICATION_PICTURE_TAPPED object:nil];
    
    CGPoint position = CGPointMake(0, 0);
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * [[[QIPictureManager sharedManager] pictures] count], self.frame.size.height)];
    
    for (UIImage *picture in [[QIPictureManager sharedManager] pictures]) {
        UIImageView *pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(position.x, position.y, self.frame.size.width, self.frame.size.height)];
        [pictureView setImage:picture];
        [pictureView setContentMode:UIViewContentModeScaleAspectFit];
        [contentView addSubview:pictureView];
        
        position = CGPointMake(position.x + self.frame.size.width, 0);
    }
    
    [self addSubview:contentView];
    self.contentSize = CGSizeMake(self.frame.size.width * [[[QIPictureManager sharedManager] pictures] count], self.frame.size.height);
}

- (void)pictureTapped:(NSNotification *)notification {
    NSIndexPath *indexPath = [notification.userInfo objectForKey:@"pictureIndexPath"];
    
    self.contentOffset = CGPointMake(self.frame.size.width * indexPath.row, 0);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
