//
//  BBApiRegistrationOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiRegistrationResponse : Jastor
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSNumber *pin;
@property (nonatomic, retain) NSNumber *userId;
@end

@interface BBApiRegistrationOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiRegistrationResponse *response;
@end
