//
//  InfoViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 15.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OHAttributedLabel/OHAttributedLabel.h>
#import "BLScrollView.h"

@interface InfoViewController : UIViewController {
    IBOutlet BLScrollView *scrollView;
    IBOutlet OHAttributedLabel *teaserLabel;
}

@end
