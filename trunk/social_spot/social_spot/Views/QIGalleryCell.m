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
    
    _isSelected = NO;
    
    _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.bounds.origin.x + 5, self.contentView.bounds.origin.y + 5, self.contentView.bounds.size.width - 10, self.contentView.bounds.size.height - 10)];
    [_pictureView setContentMode:UIViewContentModeScaleAspectFit];
    _pictureView.layer.borderColor = [UIColor whiteColor].CGColor;
    _pictureView.layer.borderWidth = 5;
    _pictureView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    _pictureView.layer.shadowRadius = 3;
    _pictureView.layer.shadowOffset = CGSizeMake(0, 1);
    _pictureView.layer.shadowOpacity = 0.5;
    [_pictureView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_pictureView];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _pictureView.frame = CGRectMake(self.contentView.bounds.origin.x + 5, self.contentView.bounds.origin.y + 5, self.contentView.bounds.size.width - 10, self.contentView.bounds.size.height - 10);
    _pictureView.image = nil;
}

- (void)changeIsSelected {
    if (_isSelected) {
        _isSelected = NO;
        _pictureView.layer.borderColor = [UIColor whiteColor].CGColor;
        [_pictureView setBackgroundColor:[UIColor whiteColor]];
    }
    else {
        _isSelected = YES;
        _pictureView.layer.borderColor = RED_TEXT_COLOR.CGColor;
        [_pictureView setBackgroundColor:RED_TEXT_COLOR];
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    if (_isSelected) {
        _pictureView.layer.borderColor = RED_TEXT_COLOR.CGColor;
        [_pictureView setBackgroundColor:RED_TEXT_COLOR];
    }
    else {
        _pictureView.layer.borderColor = [UIColor whiteColor].CGColor;
        [_pictureView setBackgroundColor:[UIColor whiteColor]];
    }
}

@end
