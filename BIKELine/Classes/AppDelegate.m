//
//  AppDelegate.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "AppDelegate.h"
#import "Crittercism.h"
#import "BBApi.h"

@implementation AppDelegate
@synthesize storyboard;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Initialize Crittercism
    [Crittercism enableWithAppID:CRITTERCISM_APP_ID];

    // Initialize Google Analytics
    [GAI sharedInstance].dispatchInterval = GOOGLE_ANALYTICS_DISPATCH;
    [[GAI sharedInstance] trackerWithTrackingId:GOOGLE_ANALYTICS_ID];
    
#ifdef DEBUG
    [GAI sharedInstance].debug = YES;
#else
    [GAI sharedInstance].debug = NO;
#endif

    
// When we are in debug mode then reset biker to prevent auto-login
#ifdef DEBUG
    [BLStandardUserDefaults setBiker:nil];
#endif
    
    // Check if user is loggedin 
    BikerMO *biker = BLStandardUserDefaults.biker;
    if (biker.userId && biker.eMail && biker.pin) {
        [self loadMainStoryboard];
    } else {
        [self loadLoginStoryboard];
    }
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:[storyboard instantiateInitialViewController]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark
#pragma mark - Public methods

+ (AppDelegate *)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


#pragma mark
#pragma mark - Private methods

- (void)loadLoginStoryboard {
    storyboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
}

- (void)loadMainStoryboard {
    storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
}

- (void)loginUser {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.window cache:YES];
    
	[self loadMainStoryboard];
    [self.window setRootViewController:[storyboard instantiateInitialViewController]];
	
	[UIView commitAnimations];
}

- (void)logoutUser {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.window cache:YES];
    
	[self loadLoginStoryboard];
    [self.window setRootViewController:[storyboard instantiateInitialViewController]];
	
	[UIView commitAnimations];
}

@end
