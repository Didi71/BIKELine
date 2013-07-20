//
//  FactsViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UISegmentedControl *segmentControl;
    IBOutlet UIView *factsView;
    IBOutlet UITableView *checkinsView;
}

@end