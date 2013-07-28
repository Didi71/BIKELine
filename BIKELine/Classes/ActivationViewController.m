//
//  ActivationViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "ActivationViewController.h"
#import "BBApi.h"
#import "TeamViewController.h"

@implementation ActivationViewController
@synthesize bikerInfo;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = NSLocalizedString(@"activationViewTitle", @"");
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [headerLabel setText:[NSString stringWithFormat:NSLocalizedString(@"activationViewHeaderText", @""), bikerInfo.firstName]];

#ifdef DEBUG
    pinTextField.text = [bikerInfo.pin stringValue];
#else
    [pinTextField becomeFirstResponder];
#endif
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TeamViewController *nextView = [segue destinationViewController];
    nextView.bikerInfo = bikerInfo;
}


#pragma mark
#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    float keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    
    [scrollView setFrame:CGRectMake(scrollView.frame.origin.x,
                                    scrollView.frame.origin.y,
                                    scrollView.frame.size.width,
                                    self.view.frame.size.height - keyboardHeight)];
    
    [UIView commitAnimations];
    
    CGSize contentSize = CGSizeMake(scrollView.frame.size.width, activateButton.frame.origin.y + activateButton.frame.size.height + 10.0);
    
    if (contentSize.height > scrollView.frame.size.height) {
        [scrollView setContentSize:contentSize];
        [scrollView setScrollEnabled:YES];
        [scrollView flashScrollIndicators];
    } else {
        [scrollView setScrollEnabled:NO];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [scrollView setFrame:CGRectMake(scrollView.frame.origin.x,
                                    scrollView.frame.origin.y,
                                    scrollView.frame.size.width,
                                    self.view.frame.size.height)];
    
    [scrollView setScrollEnabled:NO];
}


#pragma mark
#pragma mark - Actions

- (IBAction)activateButtonPressed:(id)sender {
    if (pinTextField.text.length == 0) {
        return;
    }
    
    bikerInfo.pin = [NSNumber numberWithDouble:[pinTextField.text doubleValue]];

    // Display progressHUD
    [self.view endEditing:YES];
    
    [self showHUDWithProgressMessage: NSLocalizedString(@"progressActivationText", @"")
                   andSuccessMessage: NSLocalizedString(@"successActivationText", @"")];
    
    
    // Call API
    BBApiActivationOperation *op = [SharedAPI activateUserWithId: bikerInfo.userId
                                               andActivationCode: bikerInfo.pin];
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
        
        if (bikerInfo.avatar) {
            [self showHUDWithProgressMessage: NSLocalizedString(@"progressUploadAvatarText", @"")
                           andSuccessMessage: nil];
            
            BBApiUploadAvatarOperation *op2 = [SharedAPI uploadAvatar: UIImageJPEGRepresentation(bikerInfo.avatar, 1.0)
                                                           forBikerId: bikerInfo.userId
                                                               andPIN: bikerInfo.pin];
            
            [op2 setCompletionBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [BLStandardUserDefaults setBiker:bikerInfo];
                    
                    [self hideHUD:NO];
                    [self performSegueWithIdentifier:@"ActivateToTeamSegue" sender:nil];
                });
            }];
            
            [SharedAPI.queue addOperation:op2];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [BLStandardUserDefaults setBiker:bikerInfo];
                
                [self hideHUD:NO];
                [self performSegueWithIdentifier:@"ActivateToTeamSegue" sender:nil];
            });
        }
    }];
    
    [SharedAPI.queue addOperation:op];
}


@end
