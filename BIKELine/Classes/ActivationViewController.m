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
@synthesize registration_userId, registration_name, registration_pin;

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
    
    [headerLabel setText:[NSString stringWithFormat:NSLocalizedString(@"activationViewHeaderText", @""), registration_name]];
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

    BBApiActivationOperation *op = [SharedAPI activateUserWithId: registration_userId
                                               andActivationCode: [NSNumber numberWithDouble:[pinTextField.text doubleValue]]];
    __weak BBApiActivationOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode intValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SharedAPI displayError:wop.response.errorCode];
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"ActivateToTeamSegue" sender:nil];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}


@end
