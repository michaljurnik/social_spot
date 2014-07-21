//
//  QIPageViewController.m
//  socialspot
//
//  Created by Michal Jurník on 20/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIPageContainerViewController.h"

@interface QIPageContainerViewController ()

@end

@implementation QIPageContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create page view controller
    _pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:PAGE_VIEW_CONTROLLER];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    QIPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [_pageViewController didMoveToParentViewController:self];
    
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UIViewController *firstViewController = [storybord instantiateViewControllerWithIdentifier:FIRST_VIEW_CONTROLLER];
    UIViewController *secondViewController = [storybord instantiateViewControllerWithIdentifier:SECOND_VIEW_CONTROLLER];
    UIViewController *thirdViewController = [storybord instantiateViewControllerWithIdentifier:THIRD_VIEW_CONTROLLER];
    UIViewController *fourthViewController = [storybord instantiateViewControllerWithIdentifier:FOURTH_VIEW_CONTROLLER];
    
    _controllers = @[firstViewController, secondViewController, thirdViewController, fourthViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextPage:) name:NOTIFICATION_NEXT_PAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(previousPage:) name:NOTIFICATION_PREVIOUS_PAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swipeToFirst:) name:NOTIFICATION_SHARE_COMPLETE object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            for (UIGestureRecognizer *recognizer in view.gestureRecognizers) {
                recognizer.enabled = NO;
            }
        }
    }
}

- (void)nextPage:(NSDictionary *)userInfo {
    UIViewController *viewController = [self.pageViewController.viewControllers lastObject];
    NSInteger index = [self indexOfPage:viewController];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_pageViewController setViewControllers:@[[self viewControllerAtIndex:index + 1]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    });
}

- (void)previousPage:(NSDictionary *)userInfo {
    UIViewController *viewController = [self.pageViewController.viewControllers lastObject];
    NSInteger index = [self indexOfPage:viewController];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_pageViewController setViewControllers:@[[self viewControllerAtIndex:index - 1]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    });
}

- (void)swipeToFirst:(NSDictionary *)userInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_pageViewController setViewControllers:@[[self viewControllerAtIndex:0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    });
}

- (NSInteger)indexOfPage:(UIViewController *)viewController {
    if ([[viewController class]  isEqual:[QIIntroViewController class]]) {
        return 0;
    }
    
    if ([[viewController class] isEqual:[QIGalleryViewController class]]) {
        return 1;
    }
    
    if ([[viewController class] isEqual:[QILayoutViewController class]]) {
        return 2;
    }
    
    if ([[viewController class] isEqual:[QIFrameViewController class]]) {
        return 3;
    }
    
    if ([[viewController class] isEqual:[QIShareViewController class]]) {
        return 4;
    }
    
    return 0;
}

#pragma mark - UIPageViewDataControllerSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((QIPageContentViewController *)viewController).pageIndex;
    
    if (index == 0) {
        index = 5;
    }
    else if (index == NSNotFound) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((QIPageContentViewController *) viewController).pageIndex;
    
    if (index == 5) {
        index = -1;
    }
    else if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    return [self viewControllerAtIndex:index];
}

- (QIPageContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    QIPageContentViewController *contentViewController;
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    switch (index) {
        case 0:
            contentViewController = [storybord instantiateViewControllerWithIdentifier:FIRST_VIEW_CONTROLLER];
            break;
        case 1:
            contentViewController = [storybord instantiateViewControllerWithIdentifier:SECOND_VIEW_CONTROLLER];
            break;
        case 2:
            contentViewController = [storybord instantiateViewControllerWithIdentifier:THIRD_VIEW_CONTROLLER];
            break;
        case 3:
            contentViewController = [storybord instantiateViewControllerWithIdentifier:FOURTH_VIEW_CONTROLLER];
            break;
        case 4:
            contentViewController = [storybord instantiateViewControllerWithIdentifier:FIFTH_VIEW_CONTROLLER];
            break;
        default:
            contentViewController = [storybord instantiateViewControllerWithIdentifier:FIRST_VIEW_CONTROLLER];
            break;
    }
    
    return contentViewController;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    //QIPageContentViewController *viewController = [self.viewControllers lastObject];
    //pageControl.currentPage = viewController.pageIndex;
    //[pageControl updateCurrentPageDisplay];
}


@end
