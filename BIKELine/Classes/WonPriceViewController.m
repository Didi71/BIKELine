//
//  WonPriceViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 10.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "WonPriceViewController.h"
#import "QRReaderViewController.h"
#import "NewStatsViewController.h"

@implementation WonPriceViewController
@synthesize checkinResponse;

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
    
    priceTextLabel.text = checkinResponse.priceText;
}

- (void)viewWillAppear:(BOOL)animated {
    NSURL *fanFarePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"fanfare" ofType:@"mp3"]];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fanFarePath error:nil];
    [player play];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[NewStatsViewController class]]) {
        NewStatsViewController *newStatsView = [segue destinationViewController];
        newStatsView.checkinResponse = checkinResponse;
    }
}

@end
