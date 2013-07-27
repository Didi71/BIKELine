//
//  LoginViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "LoginViewController.h"
#import "BBApi.h"
#import "AppDelegate.h"
#import "ActivationViewController.h"

@implementation LoginViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        bikerInfo = BLStandardUserDefaults.biker;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [teaserLabel setText:NSLocalizedString(@"loginViewTeaserText", @"")];
    [eMailTextField setPlaceholder:NSLocalizedString(@"placeholderEMailTitle", @"")];
    [loginButton setTitle:NSLocalizedString(@"buttonLoginTitle", @"") forState:UIControlStateNormal];
}

#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[ActivationViewController class]]) {
        ActivationViewController *nextView = [segue destinationViewController];
        nextView.bikerInfo = bikerInfo;
    }
}


#pragma mark
#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];

    [self layoutInterfaceWithOffset:-keyboardHeight];
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationDuration];
    
    [self layoutInterfaceWithOffset:keyboardHeight];
    
    [UIView commitAnimations];
    
    keyboardHeight = 0;
}


#pragma mark
#pragma mark - Actions

- (IBAction)loginButtonPressed:(id)sender {
    if (bikerInfo.eMail.length == 0) {
        return;
    }
    
    bikerInfo.eMail = eMailTextField.text;
    
    
    // Display progressHUD
    [self.view endEditing:YES];
    
    [self showHUDWithProgressMessage: NSLocalizedString(@"progressLoginText", @"")
                   andSuccessMessage: NSLocalizedString(@"successLoginText", @"")];
    
    
    // Setup API-Call
    BBApiLoginOperation *op = [SharedAPI loginUserWitheMail:bikerInfo.eMail];
    __weak BBApiLoginOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode intValue] == 32) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHUD:YES];
                [self performSegueWithIdentifier:@"LoginToRegisterSegue" sender:nil];
            });
            return;
        } else if ([wop.response.errorCode intValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHUD:YES];
                [SharedAPI displayError:wop.response.errorCode];
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            bikerInfo.userId = wop.response.userId;
            bikerInfo.firstName = wop.response.firstName;
            bikerInfo.pin = wop.response.pin;
            
            [self hideHUD:NO];
            [self performSegueWithIdentifier:@"LoginToActivateSegue" sender:nil];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}


#pragma mark
#pragma mark - Private methods

- (void)layoutInterfaceWithOffset:(float)offset {
    if (offset < 0) {
        [logoImageView setAlpha:0];
    } else {
        [logoImageView setAlpha:1.0];
    }
    
    [teaserLabel setFrame:CGRectMake(teaserLabel.frame.origin.x,
                                       teaserLabel.frame.origin.y + offset,
                                       teaserLabel.frame.size.width,
                                       teaserLabel.frame.size.height)];
    
    [eMailTextField setFrame:CGRectMake(eMailTextField.frame.origin.x,
                                        eMailTextField.frame.origin.y + offset,
                                        eMailTextField.frame.size.width,
                                        eMailTextField.frame.size.height)];
    
    [loginButton setFrame:CGRectMake(loginButton.frame.origin.x,
                                     loginButton.frame.origin.y + offset,
                                     loginButton.frame.size.width,
                                     loginButton.frame.size.height)];
}


@end
