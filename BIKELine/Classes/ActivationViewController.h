//
//  ActivationViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLViewController.h"

@interface ActivationViewController : BLViewController {
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *teaserLabel;
    IBOutlet UITextField *pinTextField;
    IBOutlet UIButton *activateButton;
}

@property (nonatomic, retain) __block BikerMO *bikerInfo;

@end
