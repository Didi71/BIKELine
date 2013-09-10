//
//  NewStatsViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 10.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "NewStatsViewController.h"
#import "QRReaderViewController.h"

@implementation NewStatsViewController

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
    
    [bikebirds.layer setCornerRadius:67.5];
    [bikebirds.layer setMasksToBounds:YES];
    [rank.layer setCornerRadius:67.5];
    [rank.layer setMasksToBounds:YES];
    [wonBikebirds.layer setCornerRadius:20.0];
    [wonBikebirds.layer setMasksToBounds:YES];
}


#pragma mark
#pragma mark - Custom Getter & Setter 

- (void)setCheckinResponse:(BBApiCheckinResponse *)response {
    bikebirdName.text = response.checkPointName;
    bikebirdCity.text = response.checkPointCity;
    
    OHParagraphStyle *paragraphStyle = [OHParagraphStyle defaultParagraphStyle];
    paragraphStyle.textAlignment = kCTCenterTextAlignment;
    paragraphStyle.lineBreakMode = kCTLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 6.0;
    
    NSString *bikeBirds = response.bikebirds == nil ? @"0" : [response.bikebirds stringValue];
    NSMutableAttributedString *attrStr1 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n%@", bikeBirds, NSLocalizedString(@"factsViewBikerBikebirdsLabel", @"")]];
    [attrStr1 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:45.0] range:[attrStr1.string rangeOfString:bikeBirds]];
    [attrStr1 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0] range:[attrStr1.string rangeOfString:NSLocalizedString(@"factsViewBikerBikebirdsLabel", @"")]];
    [attrStr1 setTextColor:[UIColor whiteColor]];
    [attrStr1 setParagraphStyle:paragraphStyle];
    bikebirdsLabel.attributedText = attrStr1;
    
    NSString *rankString = response.rank == nil ? @"0" : [response.rank stringValue];
    NSMutableAttributedString *attrStr2 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n%@", rankString, NSLocalizedString(@"factsViewBikerRankLabel", @"")]];
    [attrStr2 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:45.0] range:[attrStr2.string rangeOfString:rankString]];
    [attrStr2 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0] range:[attrStr2.string rangeOfString:NSLocalizedString(@"factsViewBikerRankLabel", @"")]];
    [attrStr2 setTextColor:[UIColor whiteColor]];
    [attrStr2 setParagraphStyle:paragraphStyle];
    rankLabel.attributedText = attrStr2;
}


#pragma mark
#pragma mark - IBActions

- (IBAction)nextButtonPressed:(id)sender {
    if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[QRReaderViewController class]]) {
        QRReaderViewController *reader = (QRReaderViewController *)[self.navigationController.viewControllers objectAtIndex:0];
        
        if (reader.lastSelectedIndex) {
            [self.tabBarController setSelectedIndex:[reader.lastSelectedIndex intValue]];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return;
        }
    }
    
    [self.tabBarController setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
