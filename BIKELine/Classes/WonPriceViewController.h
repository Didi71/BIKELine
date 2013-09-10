//
//  WonPriceViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 10.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBApiCheckinOperation.h"

@interface WonPriceViewController : UIViewController {
    IBOutlet UILabel *topLabel;
    IBOutlet UILabel *priceTextLabel;
    IBOutlet UIButton *nextButton;
    
    BBApiCheckinResponse *bufferResponse;
}

@property (nonatomic, retain) BBApiCheckinResponse *checkinResponse;

@end
