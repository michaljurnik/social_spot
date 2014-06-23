//
//  QIPhotoContainerViewController.m
//  socialspot
//
//  Created by Michal Jurník on 20/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIPhotoContainerViewController.h"

@interface QIPhotoContainerViewController ()

@end

#define PADDING 13.0

@implementation QIPhotoContainerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _imageControllers = [[NSMutableArray alloc] init];
    _imageGroups = @[@[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2a"], [UIImage imageNamed:@"2b"], [UIImage imageNamed:@"3"], [UIImage imageNamed:@"2b"], [UIImage imageNamed:@"3"], [UIImage imageNamed:@"1"], [UIImage imageNamed:@"2a"], [UIImage imageNamed:@"1"], [UIImage imageNamed:@"2a"], [UIImage imageNamed:@"1"], [UIImage imageNamed:@"2a"]],
                     @[[UIImage imageNamed:@"2b"], [UIImage imageNamed:@"3"]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoDragged:) name:NOTIFICATION_PHOTO_DRAGGED object:nil];

    [self reloadImages];
    [self changeActiveLayoutButton:_layoutButton1];
    [self changeLayoutPhoto:1];
}

- (void)changeTab:(NSUInteger)index {
    _index = index;
    [self removeAllImages];
    [self reloadImages];
}

- (void)photoDragged:(NSNotification *)notification {
    if (!_draggedViewController) {
        QIPhotoView *photoView = [notification.userInfo objectForKey:@"dragged_object"];
        
        _draggedViewController = [self photoViewCopy:photoView];
        _draggedViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
        _draggedViewController.view.layer.shadowOffset = CGSizeMake(0, 4);
        _draggedViewController.view.layer.shadowOpacity = 0.9;
        _draggedViewController.view.layer.shadowRadius = 15.0;
        _draggedViewController.view.clipsToBounds = NO;
    }
}

#pragma mark - Actions

- (IBAction)handlePan:(id)sender {
    CGPoint location = [_panGestureRecognizer locationInView:self.view];
    
    if (_panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self.view addSubview:_draggedViewController.view];
    }
    
    if (_draggedViewController) {
        [UIView animateWithDuration:0.0001 animations:^{
            [_draggedViewController.view setFrame:CGRectMake(location.x - _draggedViewController.view.frame.size.width / 2, location.y - _draggedViewController.view.frame.size.height / 2, _draggedViewController.view.frame.size.width, _draggedViewController.view.frame.size.height)];
        } completion:^(BOOL finished) {
            if (![self highlightDropView:_layoutViewController.imageView5 location:location]) {
                if (![self highlightDropView:_layoutViewController.imageView4 location:location]) {
                    if (![self highlightDropView:_layoutViewController.imageView3 location:location]) {
                        if (![self highlightDropView:_layoutViewController.imageView2 location:location]) {
                            [self highlightDropView:_layoutViewController.imageView1 location:location];
                        }
                    }
                }
            }
        }];
    }
    
    if (_panGestureRecognizer.state == UIGestureRecognizerStateEnded ||
        _panGestureRecognizer.state == UIGestureRecognizerStateCancelled ||
        _panGestureRecognizer.state == UIGestureRecognizerStateFailed) {
        
        if (![self checkDropView:_layoutViewController.imageView5 location:location]) {
            if (![self checkDropView:_layoutViewController.imageView4 location:location]) {
                if (![self checkDropView:_layoutViewController.imageView3 location:location]) {
                    if (![self checkDropView:_layoutViewController.imageView2 location:location]) {
                        [self checkDropView:_layoutViewController.imageView1 location:location];
                    }
                }
            }
        }
        
        [self removeHighlightedDropView];
        
        [_draggedViewController.view removeFromSuperview];
        _draggedViewController = nil;
    }
}

- (BOOL)checkDropView:(UIImageView *)layoutPhotoView location:(CGPoint)location {
    if ([self isDragInsideView:layoutPhotoView location:location]) {
        QIPhotoView *photoView = (QIPhotoView *)_draggedViewController.view;
        [layoutPhotoView setImage:photoView.imageView.image];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)highlightDropView:(UIImageView *)layoutPhotoView location:(CGPoint)location {
    if ([self isDragInsideView:layoutPhotoView location:location]) {
        layoutPhotoView.layer.borderWidth = 2.0;
        layoutPhotoView.layer.borderColor = RED_TEXT_COLOR.CGColor;
        
        return YES;
    }
    else {
        layoutPhotoView.layer.borderWidth = 0;
    }
    
    return NO;
}

- (void)removeHighlightedDropView {
    NSLog(@"%@", _layoutViewController);
    
    _layoutViewController.imageView1.layer.borderWidth = 0;
    _layoutViewController.imageView2.layer.borderWidth = 0;
    _layoutViewController.imageView3.layer.borderWidth = 0;
    _layoutViewController.imageView4.layer.borderWidth = 0;
    _layoutViewController.imageView5.layer.borderWidth = 0;
}

- (BOOL)isDragInsideView:(UIImageView *)imageView location:(CGPoint)location {
    CGPoint viewLocation = [imageView.superview convertPoint:imageView.frame.origin toView:self.view];
    
    if (viewLocation.y >= 0) {
        if (viewLocation.x <= location.x && viewLocation.x + imageView.frame.size.width >= location.x &&
            viewLocation.y <= location.y && viewLocation.y + imageView.frame.size.height >= location.y) {
            return YES;
        }
    }
    
    return NO;
}

- (IBAction)layoutButtonTapped:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    [self changeActiveLayoutButton:button];
    
    if ([button isEqual:_layoutButton1]) {
        [self changeLayoutPhoto:1];
    }
    
    if ([button isEqual:_layoutButton2]) {
        [self changeLayoutPhoto:2];
    }
    
    if ([button isEqual:_layoutButton3]) {
        [self changeLayoutPhoto:3];
    }
    
    if ([button isEqual:_layoutButton4]) {
        [self changeLayoutPhoto:4];
    }
    
    if ([button isEqual:_layoutButton5]) {
        [self changeLayoutPhoto:5];
    }
    
    if ([button isEqual:_layoutButton6]) {
        [self changeLayoutPhoto:6];
    }
}

- (IBAction)leftButtonTapped:(id)sender {
    float w = _scrollView.frame.size.width;
    float h = _scrollView.frame.size.height;
    float newPosition = _scrollView.contentOffset.x - w;
    CGRect toVisible = CGRectMake(newPosition, 0, w, h);
    
    [_scrollView scrollRectToVisible:toVisible animated:YES];
}

- (IBAction)rightButtonTapped:(id)sender {
    float w = _scrollView.frame.size.width;
    float h = _scrollView.frame.size.height;
    float newPosition = _scrollView.contentOffset.x + w;
    CGRect toVisible = CGRectMake(newPosition, 0, w, h);
    
    [_scrollView scrollRectToVisible:toVisible animated:YES];
}

#pragma mark - ScrollView

- (void)reloadImages {
    CGPoint location = CGPointMake(0, 0);
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    NSArray *images = [_imageGroups objectAtIndex:_index];
    
    for (UIImage *image in images) {
        if (image) {
            QIPhotoViewController *photoViewController = [storybord instantiateViewControllerWithIdentifier:PHOTO_VIEW_CONTROLLER];
            QIPhotoView *photoView = (QIPhotoView *)photoViewController.view;
            
            photoView.frame = CGRectMake(location.x + PADDING, 0, photoView.frame.size.width, photoView.frame.size.height);
            location = CGPointMake(location.x + photoView.frame.size.width + PADDING, 0);
            
            [photoView.imageView setImage:image];
            
            [_scrollView addSubview:photoViewController.view];
            [_imageControllers addObject:photoViewController];
        }
    }
    
    _scrollView.contentSize = CGSizeMake(location.x + [[_imageControllers lastObject] view].frame.size.width + PADDING, _scrollView.frame.size.height);
}

- (void)removeAllImages {
    for (UIViewController *viewController in _imageControllers) {
        [viewController.view removeFromSuperview];
    }
    
    [_imageControllers removeAllObjects];
}

- (QIPhotoViewController *)photoViewCopy:(QIPhotoView *)draggedPhotoView {
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    QIPhotoViewController *photoViewController = [storybord instantiateViewControllerWithIdentifier:PHOTO_VIEW_CONTROLLER];
    QIPhotoView *photoView = (QIPhotoView *)photoViewController.view;
    
    CGPoint location = [draggedPhotoView convertPoint:draggedPhotoView.frame.origin toView:self.view];
    photoView.frame = CGRectMake(location.x, location.y, draggedPhotoView.frame.size.width, draggedPhotoView.frame.size.height);
    
    [photoViewController.photoView setImage:draggedPhotoView.imageView.image];
    
    return photoViewController;
}

#pragma mark - Photo Layout

- (void)changeActiveLayoutButton:(UIButton *)button {
    [self removeActiveLayoutButton];
    [button.layer setBorderWidth:2.0];
    [button.layer setBorderColor:RED_TEXT_COLOR.CGColor];
}

- (void)removeActiveLayoutButton {
    [_layoutButton1.layer setBorderWidth:0];
    [_layoutButton2.layer setBorderWidth:0];
    [_layoutButton3.layer setBorderWidth:0];
    [_layoutButton4.layer setBorderWidth:0];
    [_layoutButton5.layer setBorderWidth:0];
    [_layoutButton6.layer setBorderWidth:0];
}

- (void)changeLayoutPhoto:(NSInteger)layoutID {
    QILayoutPhotoViewController *newLayoutViewController = [self viewControllerForLayout:layoutID];
    UIView *newContainer = [self viewContainerForLayout:layoutID];
    
    if (_layoutViewController) {
        [_containerView setHidden:YES];
        [newLayoutViewController.imageView1 setImage:_layoutViewController.imageView1.image];
        [newLayoutViewController.imageView2 setImage:_layoutViewController.imageView2.image];
        [newLayoutViewController.imageView3 setImage:_layoutViewController.imageView3.image];
        [newLayoutViewController.imageView4 setImage:_layoutViewController.imageView4.image];
        [newLayoutViewController.imageView5 setImage:_layoutViewController.imageView5.image];
    }

    _containerView = newContainer;
    _layoutViewController = newLayoutViewController;
    [_containerView setHidden:NO];
}

- (QILayoutPhotoViewController *)viewControllerForLayout:(NSInteger)layoutID {
    QILayoutPhotoViewController *viewController;
    
    switch (layoutID) {
        case 1:
            viewController = _layoutViewController1;
            break;
        case 2:
            viewController = _layoutViewController2;
            break;
        case 3:
            viewController = _layoutViewController3;
            break;
        case 4:
            viewController = _layoutViewController4;
            break;
        case 5:
            viewController = _layoutViewController5;
            break;
        case 6:
            viewController = _layoutViewController6;
            break;
        default:
            viewController = _layoutViewController1;
            break;
    }
    
    return viewController;
}

- (UIView *)viewContainerForLayout:(NSInteger)layoutID {
    UIView *view;
    
    switch (layoutID) {
        case 1:
            view = _layoutContainer1;
            break;
        case 2:
            view = _layoutContainer2;
            break;
        case 3:
            view = _layoutContainer3;
            break;
        case 4:
            view = _layoutContainer4;
            break;
        case 5:
            view = _layoutContainer5;
            break;
        case 6:
            view = _layoutContainer6;
            break;
        default:
            view = _layoutContainer1;
            break;
    }
    
    return view;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString * segueName = segue.identifier;
    
    if ([segueName isEqualToString:@"SEGUE_LAYOUT_1"]) {
        _layoutViewController1 = (QILayoutPhotoViewController *) [segue destinationViewController];
    }
    if ([segueName isEqualToString:@"SEGUE_LAYOUT_2"]) {
        _layoutViewController2 = (QILayoutPhotoViewController *) [segue destinationViewController];
    }
    if ([segueName isEqualToString:@"SEGUE_LAYOUT_3"]) {
        _layoutViewController3 = (QILayoutPhotoViewController *) [segue destinationViewController];
    }
    if ([segueName isEqualToString:@"SEGUE_LAYOUT_4"]) {
        _layoutViewController4 = (QILayoutPhotoViewController *) [segue destinationViewController];
    }
    if ([segueName isEqualToString:@"SEGUE_LAYOUT_5"]) {
        _layoutViewController5 = (QILayoutPhotoViewController *) [segue destinationViewController];
    }
    if ([segueName isEqualToString:@"SEGUE_LAYOUT_6"]) {
        _layoutViewController6 = (QILayoutPhotoViewController *) [segue destinationViewController];
    }
}

@end
