//
//  QIShareDetailViewController.m
//  social_spot
//
//  Created by Michal Jurník on 18/07/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIShareDetailViewController.h"

@interface QIShareDetailViewController ()

@end

@implementation QIShareDetailViewController


//- (void)viewDidLoad {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareViewControllerReady) name:NOTIFICATION_SHARE__VIEW_CONTROLLER_READY object:nil];
//}
//
//- (void)shareViewControllerReady {
//    [self fillPictures];
//    [self fillFrame];
//}

- (void)fillPictures {
    if ([[[QIPictureManager sharedManager] selectedPictures] count] > 0) {
        [_picture1 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:0]];
    }
    
    if ([[[QIPictureManager sharedManager] selectedPictures] count] > 1) {
        [_picture2 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:1]];
    }
    
    if ([[[QIPictureManager sharedManager] selectedPictures] count] > 2) {
        [_picture3 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:2]];
    }
    
    if ([[[QIPictureManager sharedManager] selectedPictures] count] > 3) {
        [_picture4 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:3]];
    }
    
    if ([[[QIPictureManager sharedManager] selectedPictures] count] > 4) {
        [_picture5 setImage:[[[QIPictureManager sharedManager] selectedPictures] objectAtIndex:4]];
    }
}

- (void)fillFrame {
    UIImage *frame;
    
    switch ([[QIPictureManager sharedManager] selectedFrame]) {
        case 1:
            frame = [UIImage imageNamed:@"znamka_big"];
            break;
        case 2:
            frame = [UIImage imageNamed:@"blackFrame_big"];
            break;
        case 3:
            frame = [UIImage imageNamed:@"obraz_big"];
            break;
        case 4:
            frame = [UIImage imageNamed:@"film_big"];
            break;
        case 5:
            frame = [UIImage imageNamed:@"flyPrague_big"];
            break;
        case 6:
            frame = [UIImage imageNamed:@"pink_big"];
            break;
        default:
            frame = [UIImage imageNamed:@"znamka_big"];
            break;
    }
    
    
    [_frameView setImage:frame];
    
    [[QIPictureManager sharedManager] setPicture:[[QIPictureManager sharedManager] imageWithView:self.view]];
}



@end
