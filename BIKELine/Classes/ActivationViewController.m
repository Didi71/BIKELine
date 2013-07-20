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

- (IBAction)activateButtonPressed:(id)sender {
    BBApiActivationOperation *op = [SharedAPI activateUserWithId: [NSNumber numberWithInt:11]
                                               andActivationCode: [NSNumber numberWithLong:07260]];
    
    [op setCompletionBlock:^{
        // Login user
    }];
    
    [SharedAPI.queue addOperation:op];
}


@end
