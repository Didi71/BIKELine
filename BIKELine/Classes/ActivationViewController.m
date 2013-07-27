//
//  ActivationViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "ActivationViewController.h"
#import "BBApi.h"

@implementation ActivationViewController
@synthesize bikerInfo;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [headerLabel setText:[NSString stringWithFormat:NSLocalizedString(@"activationViewHeaderText", @""), @""]];
    [teaserLabel setText:NSLocalizedString(@"activationViewTeaserText", @"")];
    [pinTextField setPlaceholder:NSLocalizedString(@"placeholderPinTitle",@"")];
    [activateButton setTitle:NSLocalizedString(@"buttonActivateTitle",@"") forState:UIControlStateNormal];
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [headerLabel setText:[NSString stringWithFormat:NSLocalizedString(@"activationViewHeaderText", @""), bikerInfo.firstName]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


#pragma mark
#pragma mark - Actions

- (IBAction)activateButtonPressed:(id)sender {
    if (pinTextField.text.length == 0) {
        return;
    }

    // Display progressHUD
    [self.view endEditing:YES];
    
    [self showHUDWithProgressMessage: NSLocalizedString(@"progressActivationText", @"")
                   andSuccessMessage: NSLocalizedString(@"successActivationText", @"")];
    
    
    // Call API
    BBApiActivationOperation *op = [SharedAPI activateUserWithId: bikerInfo.userId
                                               andActivationCode: [NSNumber numberWithDouble:[pinTextField.text doubleValue]]];
    __weak BBApiActivationOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode intValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHUD:YES];
                [SharedAPI displayError:wop.response.errorCode];
            });
            return;
        }
        
        if (bikerInfo.lastName == nil) {
            bikerInfo.lastName = wop.response.lastName;
            bikerInfo.street = wop.response.street;
            bikerInfo.postalcode = wop.response.postalCode;
            bikerInfo.city = wop.response.city;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [BLStandardUserDefaults setBiker:bikerInfo];
            
            [self hideHUD:NO];
            [self performSegueWithIdentifier:@"ActivateToTeamSegue" sender:nil];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}


@end
