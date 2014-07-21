//
//  QIShareViewController.m
//  socialspot
//
//  Created by Michal Jurník on 24/06/14.
//  Copyright (c) 2014 Quanti. All rights reserved.
//

#import "QIShareViewController.h"

@interface QIShareViewController ()

@end

@implementation QIShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:46.0]];
    [_facebookTextButton.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:30.0]];
    [_previousButton.titleLabel setFont:FONT_BUTTON];
    
    _loggedInUser = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self localizeTexts];
    [self showRightContainer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self fbDidLogout];
}

- (void)fbDidLogout {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
}

- (IBAction)previewButtonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PREVIOUS_PAGE object:nil];
}

- (IBAction)facebookButtonTapped:(id)sender {
    [[QILoadingView sharedLoader] showHUD:self.view];
    /*
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [self sessionStateChanged:session state:state error:error];
         }];
    }
     */
    [self openFacebookAuthentication];
}

-(void)openFacebookAuthentication {
    NSArray *permission = @[@"public_profile"];
    [FBSession setActiveSession: [[FBSession alloc] initWithPermissions:permission] ];
    [[FBSession activeSession] openWithBehavior:FBSessionLoginBehaviorForcingWebView completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        
        switch (status) {
            case FBSessionStateOpen:
                NSLog(@"Session opened");
                // Show the user the logged-in UI
                [self userLoggedIn];
                break;
            case FBSessionStateClosedLoginFailed: {
                //NSString *errorCode = [[error userInfo] objectForKey:FBErrorLoginFailedOriginalErrorCode];
                NSString *errorReason = [[error userInfo] objectForKey:FBErrorLoginFailedReason];
                //BOOL userDidCancel = !errorCode && (!errorReason || [errorReason isEqualToString:FBErrorLoginFailedReasonInlineCancelledValue]);
                
                if(error.code == 2 && ![errorReason isEqualToString:@"com.facebook.sdk:UserLoginCancelled"]) {
                    NSString *alertText;
                    NSString *alertTitle;
                    alertTitle = @"Som	ething went wrong";
                    alertText = [FBErrorUtility userMessageForError:error];
                    [self showMessage:alertText withTitle:alertTitle];
                }
            }
                break;
                // presently extension, log-out and invalidation are being implemented in the Facebook class
            default:
                break; // so we do nothing in response to those state transitions
        }
    }];
    permission = nil;
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error {
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}

- (void)userLoggedIn {
    NSLog(@"FB LOGGED");
    
    NSURL *url = [NSURL URLWithString:@"http://www.flyprague.cz"];
    
    FBAppCall *appCall = [FBDialogs presentShareDialogWithLink:url
                                                          name:@"Hello Facebook"
                                                       caption:nil
                                                   description:@"The 'Hello Facebook' sample application showcases simple Facebook integration."
                                                       picture:nil
                                                   clientState:nil
                                                       handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                           if (error) {
                                                               NSLog(@"Error: %@", error.description);
                                                           } else {
                                                               NSLog(@"Success!");
                                                           }
                                                       }];
    
    if (!appCall) {
        BOOL displayedNativeDialog = [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
                                                                              initialText:nil
                                                                                    image:nil
                                                                                      url:url
                                                                                  handler:nil];
        
        if (!displayedNativeDialog) {
            // Lastly, fall back on a request for permissions and a direct post using the Graph API
            [self performPublishAction:^{
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                
                if ([[QIPictureManager sharedManager] languageID] == 2) {
                    [params setObject:@"Hledáte zajímavý zážitek v Praze? Vyzkoušejte FlyPrague! http://flyprague.cz" forKey:@"name"];
                }
                else if ([[QIPictureManager sharedManager] languageID] == 3) {
                    [params setObject:@"Auf der Suche nach einem unvergesslichen Erlebnis in Prag? genießen FlyPrague! http://flyprague.cz" forKey:@"name"];
                }
                else {
                    [params setObject:@"Looking for a memorable experience in Prague? Enjoy FlyPrague! http://flyprague.cz" forKey:@"name"];
                }
                
                [params setObject:[[QIPictureManager sharedManager] picture] forKey:@"source"];
                
                // Make the request
                [FBRequestConnection startWithGraphPath:@"/me/photos"
                                             parameters:params
                                             HTTPMethod:@"POST"
                                      completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                          if (!error) {
                                              
                                              if ([[QIPictureManager sharedManager] languageID] == 2) {
                                                  UIAlertView *alertMsg=[[UIAlertView alloc]initWithTitle:nil message:@"Sdílení proběhlo úspěšně a byl jste odhlášen" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                                                  alertMsg.tag=11;
                                                  alertMsg.delegate=self;
                                                  [alertMsg show];
                                              }
                                              else if ([[QIPictureManager sharedManager] languageID] == 3) {
                                                  UIAlertView *alertMsg=[[UIAlertView alloc]initWithTitle:nil message:@"Erfolgreich Gemeinschafts. Sie wurde aus automaticaly angemeldet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                                                  alertMsg.tag=11;
                                                  alertMsg.delegate=self;
                                                  [alertMsg show];
                                              }
                                              else {
                                                  UIAlertView *alertMsg=[[UIAlertView alloc]initWithTitle:nil message:@"Shared Successfully. You has been logged out automaticaly" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                  alertMsg.tag=11;
                                                  alertMsg.delegate=self;
                                                  [alertMsg show];
                                              }
                                              
                                              //[[QIPictureManager sharedManager] setPicture:nil];
                                          } else {
                                              // An error occurred, we need to handle the error
                                              NSLog(@"%@",[NSString stringWithFormat:@"%@", error.description]);
                                          }
                                      }];
            }];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == [alertView cancelButtonIndex]) {
        NSLog(@"The cancel button was clicked for alertView");
        
        if (alertView.tag == 11) {
            [[QIPictureManager sharedManager] removeAllSelectedData];
            [[QILoadingView sharedLoader] hideHUD];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHARE_COMPLETE object:nil];
        }
    }
    // else do your stuff for the rest of the buttons (firstOtherButtonIndex, secondOtherButtonIndex, etc)
}

- (void)performPublishAction:(void(^)(void))action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                } else if (error.fberrorCategory != FBErrorCategoryUserCancelled) {
                                                    
                                                    if ([[QIPictureManager sharedManager] languageID] == 2) {
                                                        [[[UIAlertView alloc] initWithTitle:@"Špatné práva"
                                                                                    message:@"Aplikace SocialSpot nemá práva pro odeslání příspěvku"
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil] show];
                                                    }
                                                    else if ([[QIPictureManager sharedManager] languageID] == 3) {
                                                        [[[UIAlertView alloc] initWithTitle:@"Permission denied"
                                                                                    message:@"Unfähig, die Erlaubnis zu bekommen, um zu Posten"
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil] show];
                                                    }
                                                    else {
                                                        [[[UIAlertView alloc] initWithTitle:@"Permission denied"
                                                                                    message:@"Unable to get permission to post"
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil] show];
                                                    }
                                                }
                                            }];
    } else {
        action();
    }
    
}

- (void)userLoggedOut {
    NSLog(@"FB LOGGED OUT");
}

- (void)showMessage:(NSString *)alertText withTitle:(NSString *)alertTitle {
    NSLog(@"%@: %@", alertTitle, alertText);
}

- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    NSString *alertMsg;
    NSString *alertTitle;
    
    if (error) {
        alertTitle = @"Error";
        // Since we use FBRequestConnectionErrorBehaviorAlertUser,
        // we do not need to surface our own alert view if there is an
        // an fberrorUserMessage unless the session is closed.
        if (error.fberrorUserMessage && FBSession.activeSession.isOpen) {
            alertTitle = nil;
            
        } else {
            // Otherwise, use a general "connection problem" message.
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
        NSString *postId = [resultDict valueForKey:@"id"];
        if (!postId) {
            postId = [resultDict valueForKey:@"postId"];
        }
        if (postId) {
            alertMsg = [NSString stringWithFormat:@"%@\nPost ID: %@", alertMsg, postId];
        }
        alertTitle = @"Success";
    }
    
    if (alertTitle) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                   message:alertMsg
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil] show];
    }
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    _loggedInUser = user;
}

- (void)localizeTexts {
    if ([[QIPictureManager sharedManager] languageID] == 2) {
        _titleLabel.text = @"Sdílejte obrázek";
        
        [_previousButton setTitle:@"Zpět" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Zpět" forState:UIControlStateSelected];
        [_facebookTextButton setTitle:@"Sdílet na Facebook" forState:UIControlStateNormal];
        [_facebookTextButton setTitle:@"Sdílet na Facebook" forState:UIControlStateSelected];
    }
    else if ([[QIPictureManager sharedManager] languageID] == 3) {
        _titleLabel.text = @"Teilen Sie Ihr Foto";
        
        [_previousButton setTitle:@"Zurück" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Zurück" forState:UIControlStateSelected];
        [_facebookTextButton setTitle:@"Facebook veröffentlichen" forState:UIControlStateNormal];
        [_facebookTextButton setTitle:@"Facebook veröffentlichen" forState:UIControlStateSelected];
    }
    else {
        _titleLabel.text = @"Share your photo";
        
        [_previousButton setTitle:@"Previous" forState:UIControlStateNormal];
        [_previousButton setTitle:@"Previous" forState:UIControlStateSelected];
        [_facebookTextButton setTitle:@"Share to Facebook" forState:UIControlStateNormal];
        [_facebookTextButton setTitle:@"Share to Facebook" forState:UIControlStateSelected];
    }
}

- (void)showRightContainer {
    [_container1 setHidden:YES];
    [_container2 setHidden:YES];
    [_container3 setHidden:YES];
    [_container4 setHidden:YES];
    [_container5 setHidden:YES];
    [_container6 setHidden:YES];
    [_container7 setHidden:YES];
    [_container8 setHidden:YES];
    
    UIView *pictureContainer;
    
    switch ([[[QIPictureManager sharedManager] selectedPictures] count]) {
        case 1:
            pictureContainer = _container1;
            [_detailViewController1 fillPictures];
            [_detailViewController1 fillFrame];
            break;
        case 2:
            if ([[QIPictureManager sharedManager] selectedLayout] == 1) {
                pictureContainer = _container2;
                [_detailViewController2 fillPictures];
                [_detailViewController2 fillFrame];
            }
            else {
                pictureContainer = _container3;
                [_detailViewController3 fillPictures];
                [_detailViewController3 fillFrame];
            }
            break;
        case 3:
            if ([[QIPictureManager sharedManager] selectedLayout] == 1) {
                pictureContainer = _container4;
                [_detailViewController4 fillPictures];
                [_detailViewController4 fillFrame];
            }
            else {
                pictureContainer = _container5;
                [_detailViewController5 fillPictures];
                [_detailViewController5 fillFrame];
            }
            break;
        case 4:
            if ([[QIPictureManager sharedManager] selectedLayout] == 1) {
                pictureContainer = _container6;
                [_detailViewController6 fillPictures];
                [_detailViewController6 fillFrame];
            }
            else {
                pictureContainer = _container7;
                [_detailViewController7 fillPictures];
                [_detailViewController7 fillFrame];
            }
            break;
        case 5:
            pictureContainer = _container8;
            [_detailViewController8 fillPictures];
            [_detailViewController8 fillFrame];
            break;
        default:
            pictureContainer = _container1;
            [_detailViewController1 fillPictures];
            [_detailViewController1 fillFrame];
            break;
    }
    
    
    [pictureContainer setHidden:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHARE__VIEW_CONTROLLER_READY object:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString * segueName = segue.identifier;
    
    if ([segueName isEqualToString: @"DETAIL_VIEW_CONTROLLER_1"]) {
        _detailViewController1 = (QIShareDetailViewController *) [segue destinationViewController];
    }
    
    if ([segueName isEqualToString: @"DETAIL_VIEW_CONTROLLER_2"]) {
        _detailViewController2 = (QIShareDetailViewController *) [segue destinationViewController];
    }
    
    if ([segueName isEqualToString: @"DETAIL_VIEW_CONTROLLER_3"]) {
        _detailViewController3 = (QIShareDetailViewController *) [segue destinationViewController];
    }
    
    if ([segueName isEqualToString: @"DETAIL_VIEW_CONTROLLER_4"]) {
        _detailViewController4 = (QIShareDetailViewController *) [segue destinationViewController];
    }
    
    if ([segueName isEqualToString: @"DETAIL_VIEW_CONTROLLER_5"]) {
        _detailViewController5 = (QIShareDetailViewController *) [segue destinationViewController];
    }
    
    if ([segueName isEqualToString: @"DETAIL_VIEW_CONTROLLER_6"]) {
        _detailViewController6 = (QIShareDetailViewController *) [segue destinationViewController];
    }
    
    if ([segueName isEqualToString: @"DETAIL_VIEW_CONTROLLER_7"]) {
        _detailViewController7 = (QIShareDetailViewController *) [segue destinationViewController];
    }
    
    if ([segueName isEqualToString: @"DETAIL_VIEW_CONTROLLER_8"]) {
        _detailViewController8 = (QIShareDetailViewController *) [segue destinationViewController];
    }
}

@end
