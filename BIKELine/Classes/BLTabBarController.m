//
//  BLTabBarController.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLTabBarController.h"
#import "QRReaderViewController.h"
#import "BLNavigationController.h"

@implementation BLTabBarController

+ (void)load {
    // Set appeareance to remove glow
    [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage alloc] init]];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self tabBar:self.tabBar didSelectItem:[self.tabBar.items objectAtIndex:0]];
        [self setDelegate:self];
    }
    return self;
}


#pragma mark
#pragma mark - Overridden methods

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    [self tabBar:self.tabBar didSelectItem:[self.tabBar.items objectAtIndex:selectedIndex]];
}


#pragma mark
#pragma mark - Delegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item && [self.tabBar respondsToSelector:@selector(setBackgroundImage:)]) {
        NSInteger index = [tabBar.items indexOfObject:item];
        
        if (index == 0) {
            self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_maps_checked.png"];
        } else if (index == 1) {
            self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_checkin_pressed.png"];
        } else if (index == 2) {
            self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_facts_checked.png"];
        } else {
            self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_unchecked.png"];
        }
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[BLNavigationController class]]) {
        BLNavigationController *nav = (BLNavigationController *)viewController;
        
        if ([[nav.viewControllers objectAtIndex:0] isKindOfClass:[QRReaderViewController class]]) {
            QRReaderViewController *reader = (QRReaderViewController *)[nav.viewControllers objectAtIndex:0];
            reader.lastSelectedIndex = [NSNumber numberWithInt:tabBarController.selectedIndex];
            [reader showQRReader];
        }
    }
    
    return YES;
}

@end
