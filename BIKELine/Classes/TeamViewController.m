//
//  TeamViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "TeamViewController.h"
#import "AppDelegate.h"

@implementation TeamViewController
@synthesize bikerInfo;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = NSLocalizedString(@"joinTeamViewTitle", @"");
        
        selectorViewController = [[JoinTeamSelectTableViewController alloc] init];
        selectorViewController.delegate = self;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [joinButton setTitle:NSLocalizedString(@"buttonJoinTeamTitle", @"") forState:UIControlStateNormal];
    [skipButton setTitle:NSLocalizedString(@"buttonSkipTeamTitle", @"") forState:UIControlStateNormal];
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    CGSize contentSize = CGSizeMake(scrollView.frame.size.width, skipButton.frame.origin.y + skipButton.frame.size.height + 10.0);
    
    if (contentSize.height > self.view.frame.size.height) {
        [scrollView setContentSize:contentSize];
        [scrollView setScrollEnabled:YES];
        [scrollView flashScrollIndicators];
    } else {
        [scrollView setScrollEnabled:NO];
    }
}


#pragma mark
#pragma mark - Actions

- (IBAction)provinceButtonPressed:(id)sender {
    [self showHUDWithProgressMessage: NSLocalizedString(@"progressLoadProvincesTitle", @"")
                   andSuccessMessage: nil];
    
    BBApiGetProvincesOperation *op = [SharedAPI getProvinces];
    __weak BBApiGetProvincesOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode intValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHUD:NO];
                [SharedAPI displayError:wop.response.errorCode];
            });
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHUD:YES];
            
            selectorViewController.elements = wop.response.provinces;
            [self.navigationController pushViewController:selectorViewController animated:YES];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}

- (IBAction)organisationButtonPressed:(id)sender {
    [self showHUDWithProgressMessage: NSLocalizedString(@"progressLoadOrganisationsTitle", @"")
                   andSuccessMessage: nil];
    
    BBApiGetOrganisationsOperation *op = [SharedAPI getOrganisationsForProvince:selectedProvince];
    __weak BBApiGetOrganisationsOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode intValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHUD:NO];
                [SharedAPI displayError:wop.response.errorCode];
            });
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHUD:YES];
            
            selectorViewController.elements = wop.response.orgs;
            [self.navigationController pushViewController:selectorViewController animated:YES];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}

- (IBAction)teamButtonPressed:(id)sender {
    [self showHUDWithProgressMessage: NSLocalizedString(@"progressLoadBikerInOrganisationTitle", @"")
                   andSuccessMessage: nil];
    
    BBApiGetOrganisationBikersOperation *op = [SharedAPI getBikersInOrganisation:selectedOrganisation.organisationId];
    __weak BBApiGetOrganisationBikersOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode intValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHUD:NO];
                [SharedAPI displayError:wop.response.errorCode];
            });
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHUD:YES];
            
            selectorViewController.elements = wop.response.bikers;
            [self.navigationController pushViewController:selectorViewController animated:YES];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}

- (IBAction)nextButtonPressed:(id)sender {
    if (selectedProvince && selectedOrganisation && selectedTeam) {
        bikerInfo.teamId = selectedTeam.bikerId;
        [BLStandardUserDefaults setBiker:bikerInfo];
        
        [[AppDelegate appDelegate] loginUser];
    }
}

- (IBAction)skipButtonPressed:(id)sender {
    [[AppDelegate appDelegate] loginUser];
}


#pragma mark
#pragma mark - XXX delegate

- (void)joinTeamSelectTableView:(UITableView *)table selectElement:(id)element {
    if ([element isKindOfClass:[NSString class]]) {
        selectedProvince = element;
        [provinceButton setTitle:element forState:UIControlStateNormal];
    } else if ([element isKindOfClass:[BBOrganisation class]]) {
        selectedOrganisation = element;
        [organisationButton setTitle:[(BBOrganisation *)element name] forState:UIControlStateNormal];
    } else if ([element isKindOfClass:[BBOrganisationBiker class]]) {
        selectedTeam = element;
        [teamButton setTitle: [NSString stringWithFormat:@"%@ %@", [(BBOrganisationBiker *)element firstName], [(BBOrganisationBiker *)element lastName]]
                    forState: UIControlStateNormal];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
