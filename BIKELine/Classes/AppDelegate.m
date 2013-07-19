//
//  AppDelegate.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "AppDelegate.h"
#import "Crittercism.h"

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

    // Configure app
    storyboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:[storyboard instantiateInitialViewController]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
