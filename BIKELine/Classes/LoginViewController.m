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

@implementation LoginViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


#pragma mark
#pragma mark - Actions

- (IBAction)loginButtonPressed:(id)sender {    
    if (eMail.length == 0) {
        return;
    }
    
    BBApiLoginOperation *op = [SharedAPI loginUserWitheMail:eMail];
    __weak BBApiLoginOperation *wop = op;
    
    [op setCompletionBlock:^{        
        if ([wop.response.status isEqualToString:kRequestStatusNOK]) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![wop.response.status isEqualToString:@"NOK"]) {
                [BLStandardUserDefaults setEMail:eMail];
                [[AppDelegate appDelegate] loginUser];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil
                                                                message: NSLocalizedString(@"alertLoginFailedText", @"")
                                                               delegate: nil
                                                      cancelButtonTitle: NSLocalizedString(@"buttonOKTitle", @"")
                                                      otherButtonTitles: nil];
                
                [alert show];
            }
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}

- (IBAction)textFieldValueChanged:(id)sender {
    eMail = [(UITextField *)sender text];
}


@end
