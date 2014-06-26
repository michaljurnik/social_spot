//
//  QIGalleryCell.m
//  social_spot
//
//  Created by Michal Jurník on 26/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIGalleryCell.h"

@implementation QIGalleryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.bounds.origin.x + 5, self.contentView.bounds.origin.y + 5, self.contentView.bounds.size.width - 10, self.contentView.bounds.size.height - 10)];
    //[_pictureView setContentMode:UIViewContentModeScaleAspectFit];
    _pictureView.layer.borderColor = [UIColor whiteColor].CGColor;
    _pictureView.layer.borderWidth = 5;
    _pictureView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    _pictureView.layer.shadowRadius = 3;
    _pictureView.layer.shadowOffset = CGSizeMake(0, 1);
    _pictureView.layer.shadowOpacity = 0.5;
    [self.contentView addSubview:_pictureView];
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    _pictureView.image = nil;
    _pictureView.frame = self.contentView.bounds;
}

@end
