//
//  BLViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BLViewController : UIViewController {
    MBProgressHUD *progressHUD;
    NSString *successMessage;
}

- (void)showHUDWithProgressMessage:(NSString *)progress andSuccessMessage:(NSString *)success;
- (void)hideHUD:(BOOL)force;

@end
