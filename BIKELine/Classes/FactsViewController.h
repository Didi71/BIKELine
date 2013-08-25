//
//  FactsViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OHAttributedLabel/OHAttributedLabel.h>
#import "MBProgressHUD.h"

@interface FactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UISegmentedControl *segmentControl;
    IBOutlet UIView *factsView;
    IBOutlet UITableView *tableView;
    IBOutlet MBProgressHUD *progressHud;
    
    // Elements in factsView
    IBOutlet UIView *leftCircleView;
    IBOutlet UIView *rightCircleView;
    IBOutlet OHAttributedLabel *bikerNameLabel;
    IBOutlet OHAttributedLabel *bikebirdsLabel;
    IBOutlet OHAttributedLabel *rankLabel;
    
    // Data Content
    NSMutableArray *result_checkins;
    NSMutableArray *result_prices;
    NSMutableArray *result_teamRank;
}

@end
