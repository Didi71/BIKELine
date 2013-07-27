//
//  LoginViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLViewController.h"

@interface LoginViewController : BLViewController {
    IBOutlet UIImageView *logoImageView;
    IBOutlet UILabel *teaserLabel;
    IBOutlet UITextField *eMailTextField;
    IBOutlet UIButton *loginButton;
    
    __block BikerMO *bikerInfo;
    
    float keyboardHeight;
}

@end
