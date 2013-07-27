//
//  TeamViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLViewController.h"
#import "BLScrollView.h"

@interface TeamViewController : BLViewController {
    IBOutlet BLScrollView *scrollView;
    IBOutlet UILabel *teaserLabel;
    IBOutlet UIButton *provinceButton;
    IBOutlet UIButton *organisationButton;
    IBOutlet UIButton *teamButton;
    IBOutlet UIButton *joinButton;
    IBOutlet UIButton *skipButton;
}

@property (nonatomic, retain) __block BikerMO *bikerInfo;

@end
