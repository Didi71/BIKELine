//
//  EditBikerInfoViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 15.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "EditBikerInfoViewController.h"
#import "BBApi.h"

@implementation EditBikerInfoViewController

- (id)init {
    self = [super initWithNibName:@"EditBikerInfoView" bundle:nil];
    if (self) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 0, 30.0, 30.0)];
        [backButton setShowsTouchWhenHighlighted:YES];
        [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:backButton]];
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [teaserLabel setText:NSLocalizedString(@"editBikerInfoTeaserText", @"")];
    [changeUserInfoButton setTitle:NSLocalizedString(@"buttonSaveTitle", @"") forState:UIControlStateNormal];
}


#pragma mark
#pragma mark - View life cylce

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"editBikerInfoTitle", @"");
    
    bikerInfo = BLStandardUserDefaults.biker;
    
    firstNameTextField.text = bikerInfo.firstName;
    lastNameTextField.text = bikerInfo.lastName;
    cityTextField.text = bikerInfo.city;
    eMailTextField.text = bikerInfo.eMail;
    avatarImageView.image = bikerInfo.avatar;
    
    if ([bikerInfo.sex intValue] == kBikerSexMale) {
        [sexMaleButton setSelected:YES];
    } else {
        [sexFemaleButton setSelected:YES];
    }
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
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, changeUserInfoButton.frame.origin.y + changeUserInfoButton.frame.size.height + 10.0)];
    [scrollView setScrollEnabled:YES];
    [scrollView flashScrollIndicators];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [scrollView setFrame:CGRectMake(scrollView.frame.origin.x,
                                    scrollView.frame.origin.y,
                                    scrollView.frame.size.width,
                                    self.view.frame.size.height)];
    
    [scrollView setScrollEnabled:NO];
}

#pragma mark
#pragma mark - IBActions

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)changeUserInfoButtonPressed:(id)sender {
    if (firstNameTextField.text.length == 0) {
        [firstNameTextField becomeFirstResponder];
        return;
    }
    
    if (lastNameTextField.text.length == 0) {
        [lastNameTextField becomeFirstResponder];
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
    
    
    // Set values to biker info
    bikerInfo.firstName = firstNameTextField.text;
    bikerInfo.lastName = lastNameTextField.text;
    bikerInfo.city = cityTextField.text;
    bikerInfo.eMail = eMailTextField.text;
    bikerInfo.sex = [NSNumber numberWithInt:(sexMaleButton.isSelected == YES ? kBikerSexMale : kBikerSexFemale)];
    
    
    // Display progressHUD
    [self.view endEditing:YES];
    
    [self showHUDWithProgressMessage: NSLocalizedString(@"progressChangeInfoText", @"")
                   andSuccessMessage: NSLocalizedString(@"successChangeInfoText", @"")];
    
    
    // Call API
    BBApiUpdateBikerInfoOperation *op1 = [SharedAPI updateBikerInfo:bikerInfo];
    __block BBApiUpdateBikerInfoOperation *wop1 = op1;
    
    [op1 setCompletionBlock:^{
        if ([wop1.response.errorCode intValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideHUD:YES];
                [SharedAPI displayError:wop1.response.errorCode];
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [BLStandardUserDefaults setBiker:bikerInfo];
            [self hideHUD:NO];
            [self backButtonPressed:nil];
        });
    }];
    
    [SharedAPI.queue addOperation:op1];
}

@end
