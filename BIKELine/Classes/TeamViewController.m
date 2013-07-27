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

const int kTeamViewNextButtonSkipTag = 0;
const int kTeamViewNextButtonConnectTag = 1;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [nextButton setTitle:NSLocalizedString(@"buttonSkipTitle", @"") forState:UIControlStateNormal];
    [nextButton setTag:kTeamViewNextButtonSkipTag];
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
    if (nextButton.tag == kTeamViewNextButtonSkipTag) {
        [[AppDelegate appDelegate] loginUser];
        return;
    } else {
        
    }
}

@end
