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

@implementation QRReaderViewController
@synthesize imgPicker, resultTextView;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        shouldShowQRReader = YES;
    }
    return self;
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)viewDidAppear:(BOOL)animated {
    if (shouldShowQRReader) {
        ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
        reader.readerDelegate = self;
        reader.readerView.torchMode = 0;
        
        ZBarImageScanner *scanner = reader.scanner;
        
        [scanner setSymbology: (ZBAR_I25 | ZBAR_QRCODE)
                       config: ZBAR_CFG_ENABLE
                           to: 0];
        
        [self presentViewController:reader animated:YES completion:nil];
    }
}


#pragma mark
#pragma mark - ZBarReaderController delegate

- (void)readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry {
    NSLog(@"the image picker failing to read");
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
    
    NSLog(@"BARCODE= %@", symbol.data);
    NSLog(@"SYMBOL : %@", hiddenData);
    
    
    if ([hiddenData hasPrefix:BIKEBIRD_QRCODE_VERIFICATION_PREFIX]) {
        resultTextView.text = hiddenData;
        
        shouldShowQRReader = NO;
        [picker dismissViewControllerAnimated:YES completion:^{
            shouldShowQRReader = YES;
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil
                                                        message: @"QR Code not valid"
                                                       delegate: nil
                                              cancelButtonTitle: @"ok"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    shouldShowQRReader = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
        shouldShowQRReader = YES;
    }];
}


@end
