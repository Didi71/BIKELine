//
//  QRReaderViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "MBProgressHUD.h"

@interface QRReaderViewController : UIViewController <UIImagePickerControllerDelegate, ZBarReaderDelegate> {
    MBProgressHUD *progressHud;
}

- (void)showQRReader;

@end
