//
//  RegistrationViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBApiRegistrationOperation.h"

@interface RegistrationViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *teaserLabel;
    IBOutlet UIImageView *formularImageView;
    IBOutlet UIImageView *cameraImageView;
    IBOutlet UILabel *cameraLabel;
    IBOutlet UITextField *firstNameTextField;
    IBOutlet UITextField *lastNameTextField;
    IBOutlet UITextField *streetTextField;
    IBOutlet UITextField *postalCodeTextField;
    IBOutlet UITextField *cityTextField;
    IBOutlet UITextField *eMailTextField;
    IBOutlet UIButton *cameraButton;
    IBOutlet UIButton *sexMaleButton;
    IBOutlet UIButton *sexFemaleButton;
    IBOutlet UIButton *registerButton;
    
    UIImage *profilePicture;
    
    __block BBApiRegistrationResponse *response;
}

@end
