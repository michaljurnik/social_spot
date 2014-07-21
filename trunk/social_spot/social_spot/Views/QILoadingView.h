//
//  QILoadingView.h
//  social_spot
//
//  Created by Michal Jurník on 21/07/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface QILoadingView : UIView

+ (id)sharedLoader;
- (void)loadingViewInView:(UIView *)aSuperview;
- (void)showHUD:(UIView *)superView;
- (void)hideHUD;

@end
