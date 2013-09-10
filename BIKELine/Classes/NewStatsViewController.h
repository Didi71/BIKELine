//
//  NewStatsViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 10.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OHAttributedLabel/OHAttributedLabel.h>
#import "BBApiCheckinOperation.h"

@interface NewStatsViewController : UIViewController {
    IBOutlet UILabel *bikebirdName;
    IBOutlet UILabel *bikebirdCity;
    IBOutlet UIView *bikebirds;
    IBOutlet OHAttributedLabel *bikebirdsLabel;
    IBOutlet UIView *rank;
    IBOutlet OHAttributedLabel *rankLabel;
    IBOutlet UIView *wonBikebirds;
    IBOutlet UILabel *wonBikebirdsLabel;
    IBOutlet UIButton *nextButton;
}

@property (nonatomic, retain) BBApiCheckinResponse *checkinResponse;

@end
