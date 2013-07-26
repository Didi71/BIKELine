//
//  ActivationViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBApiRegistrationOperation.h"

@interface ActivationViewController : UIViewController {
    
}

@property (nonatomic, retain) NSNumber *registration_userId;
@property (nonatomic, retain) NSString *registration_name;
@property (nonatomic, retain) NSNumber *registration_pin;

@end
