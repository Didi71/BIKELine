//
//  BLViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLViewController.h"

@implementation BLViewController


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Configure navigation buttons
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpace.width = 5.0;
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 0, 20.0, 44.0)];
        [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItems = @[fixedSpace, [[UIBarButtonItem alloc] initWithCustomView:backButton]];
    }
    return self;
}


#pragma mark
#pragma mark - Actions

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark
#pragma mark - Private methods

- (void)showHUDWithProgressMessage:(NSString *)progress andSuccessMessage:(NSString *)success {
    if (!progressHUD) {
        progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [progressHUD setMode:MBProgressHUDModeIndeterminate];
        [progressHUD setRemoveFromSuperViewOnHide:YES];
    }
    
    successMessage = success;
    
    [[UIApplication sharedApplication].keyWindow addSubview:progressHUD];
    [progressHUD setLabelText:progress];
    [progressHUD show:YES];
}

- (void)hideHUD:(BOOL)force {
    if (force || !successMessage) {
        [progressHUD hide:YES];
    } else {
        [progressHUD setCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]]];
        [progressHUD setMode:MBProgressHUDModeCustomView];
        [progressHUD setLabelText:successMessage];
        [progressHUD hide:YES afterDelay:0.5];
    }
}

@end
