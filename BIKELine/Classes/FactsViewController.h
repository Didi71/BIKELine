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
#import "JoinTeamSelectTableViewController.h"
#import "BBApi.h"

@interface FactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, JoinTeamSelectorDelegate, UIActionSheetDelegate, UIAlertViewDelegate> {
    IBOutlet UISegmentedControl *segmentControl;
    IBOutlet UIView *factsView;
    IBOutlet UITableView *tableView;
    IBOutlet UIScrollView *teamSelectorView;
    IBOutlet JoinTeamSelectTableViewController *teamSelector;
    IBOutlet UILabel *teamTeaserLabel;
    IBOutlet UIButton *teamViewProvinceButton;
    IBOutlet UIButton *teamViewOrganisationButton;
    IBOutlet UIButton *teamViewTeamButton;
    IBOutlet UIButton *teamViewJoinTeamButton;
    IBOutlet MBProgressHUD *progressHud;
    
    // Elements in factsView
    IBOutlet UIView *leftCircleView;
    IBOutlet UIView *rightCircleView;
    IBOutlet OHAttributedLabel *bikerNameLabel;
    IBOutlet OHAttributedLabel *bikebirdsLabel;
    IBOutlet OHAttributedLabel *rankLabel;
    IBOutlet UIButton *settingsButton;
    
    // Data Content
    NSMutableArray *result_checkins;
    NSMutableArray *result_prices;
    NSMutableArray *result_teamCheckIns;
    
    // Result data for team selector
    NSString *result_team_province;
    BBOrganisation *result_team_organisation;
    BBOrganisationBiker *result_team_biker;
}

@end
