//
//  WonPriceViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 10.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "WonPriceViewController.h"
#import "QRReaderViewController.h"

@implementation WonPriceViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [topLabel setText:NSLocalizedString(@"wonPriceViewCongratulationsLabel", @"")];
    [nextButton setTitle:NSLocalizedString(@"buttonNextTitle", @"") forState:UIControlStateNormal];
}


#pragma mark
#pragma mark - View live cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
}


#pragma mark
#pragma mark - Custom Getters & Setters

- (void)setCheckinResponse:(BBApiCheckinResponse *)checkinResponse {
    bufferResponse = checkinResponse;
    priceTextLabel.text = checkinResponse.priceText;
}

- (BBApiCheckinResponse *)checkinResponse {
    return bufferResponse;
}

@end
