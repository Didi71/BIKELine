//
//  BBApiActivationOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiActivationResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@property (nonatomic, retain) NSNumber *userId;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSNumber *postalCode;
@property (nonatomic, retain) NSString *city;
@end

@interface BBApiActivationOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiActivationResponse *response;
@end