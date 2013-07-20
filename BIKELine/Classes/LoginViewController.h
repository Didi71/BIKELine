//
//  LoginViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController {
    IBOutlet UITextField *eMailTextField;
    IBOutlet UIButton *loginButton;
    
    __block NSString *eMail;
}

@end
