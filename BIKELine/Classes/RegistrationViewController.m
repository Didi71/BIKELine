//
//  RegistrationViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "RegistrationViewController.h"
#import "BBApi.h"
#import "ActivationViewController.h"

@implementation RegistrationViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    
    [teaserLabel setText:NSLocalizedString(@"registerViewTeaserText", @"")];
    [cameraLabel setText:NSLocalizedString(@"registerViewProfilePictureText", @"")];
    [firstNameTextField setPlaceholder:NSLocalizedString(@"placeholderFirstNameTitle", @"")];
    [lastNameTextField setPlaceholder:NSLocalizedString(@"placeholderLastNameTitle", @"")];
    [streetTextField setPlaceholder:NSLocalizedString(@"placeholderStreetTitle", @"")];
    [postalCodeTextField setPlaceholder:NSLocalizedString(@"placeholderPostalCodeTitle", @"")];
    [cityTextField setPlaceholder:NSLocalizedString(@"placeholderCityTitle", @"")];
    [eMailTextField setPlaceholder:NSLocalizedString(@"placeholderEMailTitle", @"")];
    [sexMaleButton setTitle:NSLocalizedString(@"buttonMaleTitle", @"") forState:UIControlStateNormal];
    [sexFemaleButton setTitle:NSLocalizedString(@"buttonFemaleTitle", @"") forState:UIControlStateNormal];
    [registerButton setTitle:NSLocalizedString(@"buttonRegisterTitle", @"") forState:UIControlStateNormal];
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
    ActivationViewController *nextView = [segue destinationViewController];
    nextView.registration_userId = response.userId;
    nextView.registration_name = response.firstName;
    nextView.registration_pin = response.pin;
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

- (IBAction)cameraButtonPressed:(id)sender {
    
}

- (IBAction)sexButtonPressed:(id)sender {
    if ([sender isEqual:sexMaleButton]) {
        [sexFemaleButton setSelected:NO];
        [sexFemaleButton setUserInteractionEnabled:YES];
        [sexMaleButton setSelected:YES];
        [sexMaleButton setUserInteractionEnabled:NO];
    } else {
        [sexMaleButton setSelected:NO];
        [sexMaleButton setUserInteractionEnabled:YES];
        [sexFemaleButton setSelected:YES];
        [sexFemaleButton setUserInteractionEnabled:NO];
    }
}

- (IBAction)registrationButtonPressed:(id)sender {
    if (firstNameTextField.text.length == 0) {
        [firstNameTextField becomeFirstResponder];
        return;
    }
    
    if (lastNameTextField.text.length == 0) {
        [lastNameTextField becomeFirstResponder];
        return;
    }
    
    if (streetTextField.text.length == 0) {
        [streetTextField becomeFirstResponder];
        return;
    }
    
    if (postalCodeTextField.text.length == 0) {
        [postalCodeTextField becomeFirstResponder];
        return;
    }
    
    if (cityTextField.text.length == 0) {
        [cityTextField becomeFirstResponder];
        return;
    }
    
    if (eMailTextField.text.length == 0) {
        [eMailTextField becomeFirstResponder];
        return;
    }
    
    if (!sexMaleButton.isSelected && !sexFemaleButton.isSelected) {
        return;
    }
    
    
    BBApiRegistrationOperation *op = [SharedAPI registerUserWithFirstName: firstNameTextField.text
                                                                 lastName: lastNameTextField.text
                                                                   street: streetTextField.text
                                                               postalCode: postalCodeTextField.text
                                                                     city: cityTextField.text
                                                                    eMail: eMailTextField.text
                                                                   andSex: sexMaleButton.isSelected];
    __weak BBApiRegistrationOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode intValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SharedAPI displayError:wop.response.errorCode];
            });
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            response = wop.response;
            [self performSegueWithIdentifier:@"RegisterToActivateSegue" sender:nil];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}


#pragma mark
#pragma mark - Private methods

- (void)layoutInterfaceWithOffset:(float)offset {
    
}


@end
