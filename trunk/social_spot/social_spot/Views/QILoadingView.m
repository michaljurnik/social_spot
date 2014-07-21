//
//  QILoadingView.m
//  social_spot
//
//  Created by Michal Jurník on 21/07/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QILoadingView.h"


static QILoadingView *sharedLoader = nil;

@implementation QILoadingView

+ (id)sharedLoader {
    @synchronized(self) {
        if(sharedLoader == nil)
            sharedLoader = [[QILoadingView alloc] init];
    }
    
    return sharedLoader;
}

- (QILoadingView *)init {
    self = [super init];
    
    if (self) {
        //[self loadingViewInView:[[[[[UIApplication sharedApplication] delegate] window] rootViewController] view]];
    }
    
    return self;
}

- (void)loadingViewInView:(UIView *)aSuperview {
    [self setFrame:aSuperview.frame];
    
    self.opaque = NO;
    self.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.7]];
    
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    [aSuperview addSubview:self];
}

- (void)showHUD:(UIView *)superView {
	[self loadingViewInView:superView];
}

//
// removeView
//
// Animates the view out from the superview. As the view is removed from the
// superview, it will be released.
//

- (void)hideHUD {
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
    [self removeFromSuperview];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    [super removeFromSuperview];
}


@end
