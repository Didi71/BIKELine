//
//  BLNavigationController.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLNavigationController.h"

@implementation BLNavigationController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self.navigationBar setBarStyle:UIBarStyleBlack];
        
        [self.navigationBar setBackgroundImage: [UIImage imageNamed:@"navbar.png"]
                                 forBarMetrics: UIBarMetricsDefault];
    }
    
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        [self.navigationBar setBarStyle:UIBarStyleBlack];
        
        [self.navigationBar setBackgroundImage: [UIImage imageNamed:@"navbar.png"]
                                 forBarMetrics: UIBarMetricsDefault];
    }
    
    return self;
}

@end
