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


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark
#pragma mark - Actions

- (IBAction)activateButtonPressed:(id)sender {

    BBApiActivationOperation *op = [SharedAPI activateUserWithId: registration_userId
                                               andActivationCode: registration_pin];
    __weak BBApiActivationOperation *wop = op;
    
    [op setCompletionBlock:^{
        // Login user
    }];
    
    [SharedAPI.queue addOperation:op];
}


@end
