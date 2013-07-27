//
//  TeamViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "TeamViewController.h"
#import "AppDelegate.h"

@implementation TeamViewController
@synthesize bikerInfo;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [joinButton setTitle:NSLocalizedString(@"buttonJoinTeamTitle", @"") forState:UIControlStateNormal];
    [skipButton setTitle:NSLocalizedString(@"buttonSkipTeamTitle", @"") forState:UIControlStateNormal];
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    CGSize contentSize = CGSizeMake(scrollView.frame.size.width, skipButton.frame.origin.y + skipButton.frame.size.height + 10.0);
    
    if (contentSize.height > self.view.frame.size.height) {
        [scrollView setContentSize:contentSize];
        [scrollView setScrollEnabled:YES];
        [scrollView flashScrollIndicators];
    } else {
        [scrollView setScrollEnabled:NO];
    }
}


#pragma mark
#pragma mark - Actions

- (IBAction)openSelectorButtonPressed:(id)sender {
    if ([sender isEqual:provinceButton]) {
        
    } else if ([sender isEqual:organisationButton]) {
        
    } else if ([sender isEqual:teamButton]) {
        
    }
}

- (IBAction)nextButtonPressed:(id)sender {
    [[AppDelegate appDelegate] loginUser];
}

@end
