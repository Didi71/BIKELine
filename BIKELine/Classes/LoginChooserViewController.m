//
//  LoginChooserViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "LoginChooserViewController.h"
#import "BLNavigationController.h"
#import "InfoViewController.h"

@implementation LoginChooserViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [infoButton setFrame:CGRectMake(0, 0, 30.0, 30.0)];
        [infoButton setShowsTouchWhenHighlighted:YES];
        [infoButton setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:infoButton]];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [loginButton setTitle:NSLocalizedString(@"buttonAlreadyRegisterdTitle", @"") forState:UIControlStateNormal];
    [orLabel setText:NSLocalizedString(@"loginChooserOrLabel", @"")];
    [registerButton setTitle:NSLocalizedString(@"buttonRegisterTitle", @"") forState:UIControlStateNormal];
}


#pragma mark
#pragma mark - IBActions

- (IBAction)infoButtonPressed:(id)sender {
    [self.navigationController pushViewController: [[InfoViewController alloc] init]
                                         animated: YES];
}


@end
