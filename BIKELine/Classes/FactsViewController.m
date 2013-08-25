//
//  FactsViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "FactsViewController.h"
#import "BBApi.h"

@implementation FactsViewController

const int kFactsViewSubViewFactsTag = 1;
const int kFactsViewSubViewTableTag = 2;

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

    // Configure Facts View
    [leftCircleView.layer setCornerRadius:67.5];
    [leftCircleView.layer setMasksToBounds:YES];
    [rightCircleView.layer setCornerRadius:67.5];
    [rightCircleView.layer setMasksToBounds:YES];
    
    [bikebirdsLabel setCenterVertically:YES];
    [rankLabel setCenterVertically:YES];
    
    
    // Configure TableView
    [tableView setRowHeight:60.0];
}

- (void)viewWillAppear:(BOOL)animated {
    [self getFacts];
}


#pragma mark
#pragma mark - Actions

- (IBAction)segmentControlChangedValue:(id)sender {
    switch (segmentControl.selectedSegmentIndex) {
        case 0: {
            tableView.hidden = YES;
            factsView.hidden = NO;
            [self getFacts];
            [self _hideProgressHud];
            break;
        }
        
        case 1: {
            tableView.hidden = NO;
            factsView.hidden = YES;
            [self getCheckins];
            break;
        }
            
        case 2: {
            tableView.hidden = NO;
            factsView.hidden = YES;
            [self getTeam];
            break;
        }
            
        case 3: {
            tableView.hidden = NO;
            factsView.hidden = YES;
            [self getPrices];
            break;
        }
           
        default: {
            break;
        }
    }
}


#pragma mark
#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    switch (segmentControl.selectedSegmentIndex) {   
        case 1: {
            return [result_checkins count];
        }
            
        case 2: {
            return [result_teamRank count];
        }
            
        case 3: {
            return [result_prices count];
        }
            
        default: {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (segmentControl.selectedSegmentIndex == 1) {

    } else if (segmentControl.selectedSegmentIndex == 2) {
        
    } else if (segmentControl.selectedSegmentIndex == 3) {
        
    }
    
    return cell;
}


#pragma mark
#pragma mark - Protected methods

- (void)_showProgressHudWithMessage:(NSString *)message {
    // Setup progress hud
    if (!progressHud) {
        progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        progressHud.mode = MBProgressHUDModeIndeterminate;
        progressHud.removeFromSuperViewOnHide = YES;
    }
    
    if (![progressHud.superview isEqual:self.view]) {
        [self.view addSubview:progressHud];
    }
    
    [progressHud setLabelText:message];
    [progressHud show:YES];
}

- (void)_hideProgressHud {
    [progressHud hide:YES];
}


#pragma mark
#pragma mark - Private methods

- (void)getFacts {
    BikerMO *biker = BLStandardUserDefaults.biker;
    
    OHParagraphStyle *paragraphStyle1 = [OHParagraphStyle defaultParagraphStyle];
    paragraphStyle1.textAlignment = kCTCenterTextAlignment;
    paragraphStyle1.lineBreakMode = kCTLineBreakByWordWrapping;
    paragraphStyle1.lineSpacing = 10.0;
    
    OHParagraphStyle *paragraphStyle2 = [OHParagraphStyle defaultParagraphStyle];
    paragraphStyle2.textAlignment = kCTCenterTextAlignment;
    paragraphStyle2.lineBreakMode = kCTLineBreakByWordWrapping;
    paragraphStyle2.lineSpacing = 6.0;
    
    
    // Configure Labels
    NSString *nameString = [NSString stringWithFormat:@"%@ %@", biker.firstName, biker.lastName];
    NSString *addressString = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"factsViewFromLabel", @""), @"City"];
    NSMutableAttributedString *attrStr1 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n%@", nameString, addressString]];
    [attrStr1 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22.0] range:[attrStr1.string rangeOfString:nameString]];
    [attrStr1 setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0] range:[attrStr1.string rangeOfString:addressString]];
    [attrStr1 setTextColor:[UIColor whiteColor]];
    [attrStr1 setParagraphStyle:paragraphStyle1];
    bikerNameLabel.attributedText = attrStr1;
    
    NSString *bikeBirds = biker.bikeBirds == nil ? @"0" : [biker.bikeBirds stringValue];
    NSMutableAttributedString *attrStr2 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n%@", bikeBirds, NSLocalizedString(@"factsViewBikerBikebirdsLabel", @"")]];
    [attrStr2 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:27.0] range:[attrStr2.string rangeOfString:bikeBirds]];
    [attrStr2 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0] range:[attrStr2.string rangeOfString:NSLocalizedString(@"factsViewBikerBikebirdsLabel", @"")]];
    [attrStr2 setTextColor:[UIColor whiteColor]];
    [attrStr2 setParagraphStyle:paragraphStyle2];
    bikebirdsLabel.attributedText = attrStr2;
    
    NSString *rankString = biker.rank == nil ? @"#0" : [NSString stringWithFormat:@"#%@", biker.rank];
    NSMutableAttributedString *attrStr3 = [NSMutableAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@\n%@", rankString, NSLocalizedString(@"factsViewBikerRankLabel", @"")]];
    [attrStr3 setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:27.0] range:[attrStr3.string rangeOfString:rankString]];
    [attrStr3 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0] range:[attrStr3.string rangeOfString:NSLocalizedString(@"factsViewBikerRankLabel", @"")]];
    [attrStr3 setTextColor:[UIColor whiteColor]];
    [attrStr3 setParagraphStyle:paragraphStyle2];
    rankLabel.attributedText = attrStr3;
}

- (void)getCheckins {
    [self _showProgressHudWithMessage:NSLocalizedString(@"progressLoadCheckinsLabel", @"")];
}

- (void)getTeam {
    [self _showProgressHudWithMessage:NSLocalizedString(@"progressLoadTeamLabel", @"")];
}

- (void)getPrices {
    [self _showProgressHudWithMessage:NSLocalizedString(@"progressLoadPricesLabel", @"")];
}


@end
