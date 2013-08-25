//
//  FactsViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "FactsViewController.h"
#import "BBApi.h"
#import "CustomTableViewCell.h"

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
            
            if (!result_checkins || [result_checkins count] == 0) {
                [self getCheckins:YES];
            } else {
                [self getCheckins:NO];
                [tableView reloadData];
            }
            
            break;
        }
            
        case 2: {
            tableView.hidden = NO;
            factsView.hidden = YES;
            
            if (!result_teamCheckIns || [result_teamCheckIns count] == 0) {
                [self getTeamCheckins:YES];
            } else {
                [self getTeamCheckins:NO];
                [tableView reloadData];
            }
            
            break;
        }
            
        case 3: {
            tableView.hidden = NO;
            factsView.hidden = YES;
            
            if (!result_prices || [result_prices count] == 0) {
                [self getPrices:YES];
            } else {
                [self getPrices:NO];
                [tableView reloadData];
            }
            
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
    if (segmentControl.selectedSegmentIndex == 1) {
        return 1; //[result_checkins count];
    } else if (segmentControl.selectedSegmentIndex == 2) {
        return [result_teamCheckIns count];
    } else if (segmentControl.selectedSegmentIndex == 3) {
        return [result_prices count];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (segmentControl.selectedSegmentIndex == 1 || segmentControl.selectedSegmentIndex == 2) {
        return 68.0;
    } else if (segmentControl.selectedSegmentIndex == 3) {
        return 86.0;
    } else {
        return tv.rowHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = segmentControl.selectedSegmentIndex == 3 ? @"BLTableViewCellStylePrice" : @"BLTableViewCellStyleCheckin";
    CustomTableViewCell *cell = (CustomTableViewCell *)[tv dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        if (segmentControl.selectedSegmentIndex == 1 || segmentControl.selectedSegmentIndex == 2) {
            cell = [[CustomTableViewCell alloc] initWithBLStyle:BLTableViewCellStyleCheckin reuseIdentifier:cellId];
        } else if (segmentControl.selectedSegmentIndex == 3) {
            cell = [[CustomTableViewCell alloc] initWithBLStyle:BLTableViewCellStylePrice reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (segmentControl.selectedSegmentIndex == 1) {
        BBCheckIn *checkIn = [result_checkins objectAtIndex:indexPath.row];
        
        cell.headerLabel.text = checkIn.checkPointName;
        cell.headerLabel.textColor = [UIColor whiteColor];
        cell.headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
        
        NSString *dateString = [NSDate dateWithTimeIntervalSince1970:[checkIn.date doubleValue]];
        cell.bottomLabel.text = [NSString stringWithFormat:@"%@ %@, %@", NSLocalizedString(@"factsViewInLabel", @""), checkIn.checkPointCity, dateString];
        cell.bottomLabel.textColor = [UIColor whiteColor];
        cell.bottomLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
        
        cell.leftLabel.text = [NSString stringWithFormat:@"%@", checkIn.bikebirds];
        cell.leftLabel.textColor = [UIColor whiteColor];
        cell.leftLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0];
    } else if (segmentControl.selectedSegmentIndex == 2) {
        
        
        cell.headerLabel.text = @"balalsdasd";
        cell.headerLabel.textColor = [UIColor whiteColor];
        cell.headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
        
        cell.bottomLabel.text = @"muhahaha";
        cell.bottomLabel.textColor = [UIColor whiteColor];
        cell.bottomLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
        
        cell.leftLabel.text = @"2";
        cell.leftLabel.textColor = [UIColor whiteColor];
        cell.leftLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0];
    } else if (segmentControl.selectedSegmentIndex == 3) {
        BBPrice *price = [result_prices objectAtIndex:indexPath.row];
        
        cell.headerLabel.text = price.description;
        cell.headerLabel.textColor = [UIColor whiteColor];
        cell.headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
        
        NSString *dateString = [NSDate dateWithTimeIntervalSince1970:[price.timeWon doubleValue]];
        cell.bottomLabel.text = [NSString stringWithFormat:@"%@\n%@ %@, %@", price.sponsorName, NSLocalizedString(@"factsViewInLabel", @""), price.sponsorCity, dateString];
        cell.bottomLabel.textColor = [UIColor whiteColor];
        cell.bottomLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
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

- (void)getCheckins:(BOOL)showHud {
    if (showHud) {
        [self _showProgressHudWithMessage:NSLocalizedString(@"progressLoadCheckinsLabel", @"")];
    }
    
    BBApiGetCheckinsOperation *op = [SharedAPI getCheckInsWithBikerId: BLStandardUserDefaults.biker.userId
                                                               andPin: BLStandardUserDefaults.biker.pin];
    __weak BBApiGetCheckinsOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode integerValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SharedAPI displayError:wop.response.errorCode];
                [self _hideProgressHud];
                [tableView reloadData];
            });
            return;
        }
        
        if (!result_checkins) {
            result_checkins = [[NSMutableArray alloc] initWithArray:wop.response.checkIns];
        } else {
            [result_checkins removeAllObjects];
            [result_checkins addObjectsFromArray:wop.response.checkIns];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _hideProgressHud];
            [tableView reloadData];
        });
        
        
        // Check if local bikebirds are not equal than server bikebirds
        NSInteger i = 0;
        for (BBCheckIn *checkIn in wop.response.checkIns) {
            i = i + [checkIn.bikebirds intValue];
        }
        
        if (i != [BLStandardUserDefaults.biker.bikeBirds intValue]) {
            BikerMO *biker = BLStandardUserDefaults.biker;
            biker.bikeBirds = [NSNumber numberWithInt:i];
            [BLStandardUserDefaults setBiker:biker];
        }
    }];
    
    [SharedAPI.queue addOperation:op];
}

- (void)getTeamCheckins:(BOOL)showHud {
    if (showHud) {
        [self _showProgressHudWithMessage:NSLocalizedString(@"progressLoadTeamLabel", @"")];
    }
    
    BBApiGetTeamCheckinsOperation *op = [SharedAPI getTeamCheckInsWithTeamId: BLStandardUserDefaults.biker.teamId
                                                                      andPin: BLStandardUserDefaults.biker.pin];
    __weak BBApiGetTeamCheckinsOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode integerValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SharedAPI displayError:wop.response.errorCode];
                [self _hideProgressHud];
                [tableView reloadData];
            });
            return;
        }
        
        if (!result_teamCheckIns) {
            result_teamCheckIns = [[NSMutableArray alloc] initWithArray:wop.response.teamCheckIns];
        } else {
            [result_teamCheckIns removeAllObjects];
            [result_teamCheckIns addObjectsFromArray:wop.response.teamCheckIns];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _hideProgressHud];
            [tableView reloadData];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}

- (void)getPrices:(BOOL)showHud {
    if (showHud) {
        [self _showProgressHudWithMessage:NSLocalizedString(@"progressLoadPricesLabel", @"")];
    }
    
    BBApiGetPricesOperation *op = [SharedAPI getPricesForUserId:BLStandardUserDefaults.biker.userId];
    __weak BBApiGetPricesOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode integerValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SharedAPI displayError:wop.response.errorCode];
                [self _hideProgressHud];
                [tableView reloadData];
            });
            return;
        }
        
        if (!result_prices) {
            result_prices = [[NSMutableArray alloc] initWithArray:wop.response.prices];
        } else {
            [result_prices removeAllObjects];
            [result_prices addObjectsFromArray:wop.response.prices];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _hideProgressHud];
            [tableView reloadData];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}


@end
