//
//  QRReaderViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//
//  ZBar Tutorial: http://iphonenativeapp.blogspot.co.at/2011/07/qr-code-readerscanner-for-iphone-app-in.html
//  ZBar for armv7s: http://www.federicocappelli.net/2012/10/05/zbar-library-for-iphone-5-armv7s/
//

#import "QRReaderViewController.h"
#import "BBApi.h"
#import "WonPriceViewController.h"
#import "NewStatsViewController.h"

@implementation QRReaderViewController
@synthesize lastSelectedIndex;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
#warning TODO - Werte werden nicht korrekt übergeben
    if ([[segue destinationViewController] isKindOfClass:[WonPriceViewController class]]) {
        WonPriceViewController *wonPriceView = [segue destinationViewController];
        wonPriceView.checkinResponse = responsePuffer;
    } else if ([[segue destinationViewController] isKindOfClass:[NewStatsViewController class]]) {
        NewStatsViewController *newStatsView = [segue destinationViewController];
        newStatsView.checkinResponse = responsePuffer;
    }
}


#pragma mark
#pragma mark - Protected methods

- (void)_showProgressHudWithMessage:(NSString *)message {
    // Setup progress hud
    if (!progressHud) {
        progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        progressHud.mode = MBProgressHUDModeIndeterminate;
        progressHud.removeFromSuperViewOnHide = YES;
    }
    
    if (![progressHud.superview isEqual:self.view]) {
        [self.view addSubview:progressHud];
    }
    
    [progressHud setLabelText:message];
    [progressHud show:YES];
}

- (void)_hideProgressHud {
    [progressHud hide:YES];
}


#pragma mark
#pragma mark - Private methods

- (void)showQRReader {
    ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
    reader.readerDelegate = self;
    reader.readerView.torchMode = 0;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: (ZBAR_I25 | ZBAR_QRCODE)
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    [self presentViewController: reader
                       animated: NO
                     completion: ^{
                         if (!BLStandardUserDefaults.qrReaderWasAlreadyInUse) {
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil
                                                                             message: NSLocalizedString(@"qrScannerFirstTimeUseTeaser", @"")
                                                                            delegate: nil
                                                                   cancelButtonTitle: NSLocalizedString(@"buttonOkTitle", @"")
                                                                   otherButtonTitles: nil];
                             [alert show];
                             
                             [BLStandardUserDefaults setQrReaderWasAlreadyInUse:YES];
                         }
    }];
}


#pragma mark
#pragma mark - ZBarReaderController delegate

- (void)readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry {
    NDCLog(@"the image picker failing to read");
}


#pragma mark
#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    NSString *hiddenData;
    for(symbol in results) {
        hiddenData = [NSString stringWithString:symbol.data];
    }    
    
    NDCLog(@"BARCODE = %@", symbol.data);
    NDCLog(@"SYMBOL  = %@", hiddenData);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self _showProgressHudWithMessage:NSLocalizedString(@"progressCheckInTitle", @"")];
    });
    
    if ([hiddenData hasPrefix:BIKEBIRD_QRCODE_VERIFICATION_PREFIX]) {

        NSString *cleanedData = [hiddenData stringByReplacingOccurrencesOfString: BIKEBIRD_QRCODE_VERIFICATION_PREFIX
                                                                      withString: @""];
        
        BBApiCheckinOperation *op = [SharedAPI checkinAtPoin: [NSNumber numberWithDouble:[cleanedData doubleValue]]
                                                  withUserId: BLStandardUserDefaults.biker.userId
                                                      teamId: BLStandardUserDefaults.biker.teamId
                                                      andPIN: BLStandardUserDefaults.biker.pin];
        __weak BBApiCheckinOperation *wop = op;
        
        [op setCompletionBlock:^{
            if ([wop.response.errorCode intValue] > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self _hideProgressHud];
                    [SharedAPI displayError:wop.response.errorCode];
                });
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self _hideProgressHud];
                
                BikerMO *biker = BLStandardUserDefaults.biker;
                biker.bikeBirds = [NSNumber numberWithInt:([wop.response.bikebirdsOld intValue] + [wop.response.bikebirdsOld intValue])];
                biker.rank = wop.response.rank;
                [BLStandardUserDefaults setBiker:biker];
                
                responsePuffer = wop.response;
                
                // If priceText is available, then show this to user with alert message
                if (wop.response.priceText) {
                    [self performSegueWithIdentifier:@"QRReaderToWonPriceSegue" sender:nil];
                } else {
                    [self performSegueWithIdentifier:@"QRReaderToNewStatsSegue" sender:nil];
                }
                
                [picker dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        
        [SharedAPI.queue addOperation:op];
    } else {
        [self _hideProgressHud];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (lastSelectedIndex) {
        [self.tabBarController setSelectedIndex:[lastSelectedIndex intValue]];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
