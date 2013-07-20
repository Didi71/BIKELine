//
//  RegistrationViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "RegistrationViewController.h"
#import "BBApi.h"

@implementation RegistrationViewController

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
	// Do any additional setup after loading the view.
}



#pragma mark
#pragma mark - Actions

- (IBAction)registrationButtonPressed:(id)sender {
    BBApiRegistrationOperation *op = [SharedAPI registerUserWithFirstName: @"Christoph"
                                                                 lastName: @"Lueckler"
                                                                   street: @"Bienengasse 9/15"
                                                               postalCode: @"8020"
                                                                     city: @"Graz"
                                                                 andEMail: @"oe8clr@me.com"];
    
    [op setCompletionBlock:^{
        // Push Activation view
    }];
    
    [SharedAPI.queue addOperation:op];

}



@end
