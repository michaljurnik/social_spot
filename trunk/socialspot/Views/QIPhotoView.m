//
//  QIPhotView.m
//  socialspot
//
//  Created by Michal Jurník on 20/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIPhotoView.h"

@implementation QIPhotoView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PHOTO_DRAGGED object:nil userInfo:@{@"dragged_object" : self, @"location_x" : [NSNumber numberWithInt:location.x], @"location_y" : [NSNumber numberWithInt:location.y]}];
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *aTouch = [touches anyObject];
//    CGPoint location = [aTouch locationInView:self.superview];
//    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
//    self.frame = CGRectMake(location.x, location.y,
//                            self.frame.size.width, self.frame.size.height);
//    [UIView commitAnimations];
//}

@end
