//
//  QRReaderViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OHAttributedLabel/OHAttributedLabel.h>
#import "ZBarSDK.h"
#import "MBProgressHUD.h"

@interface QRReaderViewController : UIViewController <UIImagePickerControllerDelegate, ZBarReaderDelegate> {
    
    IBOutlet UILabel *bikebirdName;
    IBOutlet UILabel *bikebirdCity;
    IBOutlet UIView *bikebirds;
    IBOutlet OHAttributedLabel *bikebirdsLabel;
    IBOutlet UIView *rank;
    IBOutlet OHAttributedLabel *rankLabel;
    IBOutlet UIView *wonBikebirds;
    IBOutlet UILabel *wonBikebirdsLabel;
    IBOutlet UIButton *nextButton;
    
    MBProgressHUD *progressHud;
}

@property (nonatomic, retain) NSNumber *lastSelectedIndex;

- (void)showQRReader;

@end
