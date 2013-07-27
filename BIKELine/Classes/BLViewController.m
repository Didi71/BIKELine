//
//  BLViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLViewController.h"

@implementation BLViewController

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
