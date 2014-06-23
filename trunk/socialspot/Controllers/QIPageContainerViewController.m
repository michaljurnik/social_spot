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
    
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    QIPageContentViewController *firstViewController = [storybord instantiateViewControllerWithIdentifier:FIRST_VIEW_CONTROLLER];
    QIPageContentViewController *secondViewController = [storybord instantiateViewControllerWithIdentifier:SECOND_VIEW_CONTROLLER];
    
    [firstViewController setPageIndex:1];
    [secondViewController setPageIndex:2];
    
    _controllers = @[firstViewController, secondViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextPage:) name:NOTIFICATION_NEXT_PAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(previousPage:) name:NOTIFICATION_PREVIOUS_PAGE object:nil];
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
    QIPageContentViewController *viewController = [self.pageViewController.viewControllers lastObject];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_pageViewController setViewControllers:@[[self viewControllerAtIndex:viewController.pageIndex + 1]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    });
}

- (void)previousPage:(NSDictionary *)userInfo {
    QIPageContentViewController *viewController = [self.pageViewController.viewControllers lastObject];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_pageViewController setViewControllers:@[[self viewControllerAtIndex:viewController.pageIndex - 1]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    });
}

#pragma mark - UIPageViewDataControllerSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((QIPageContentViewController *)viewController).pageIndex;
    
    if (index == 0) {
        index = 3;
    }
    else if (index == NSNotFound) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((QIPageContentViewController *) viewController).pageIndex;
    
    if (index == 2) {
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
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    switch (index) {
        case 0:
            contentViewController = [storybord instantiateViewControllerWithIdentifier:FIRST_VIEW_CONTROLLER];
            break;
        case 1:
            contentViewController = [storybord instantiateViewControllerWithIdentifier:SECOND_VIEW_CONTROLLER];
            break;
        default:
            contentViewController = [storybord instantiateViewControllerWithIdentifier:FIRST_VIEW_CONTROLLER];
            break;
    }
    // Create a new view controller and pass suitable data.
    
    return contentViewController;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    //QIPageContentViewController *viewController = [self.viewControllers lastObject];
    //pageControl.currentPage = viewController.pageIndex;
    //[pageControl updateCurrentPageDisplay];
}


@end
