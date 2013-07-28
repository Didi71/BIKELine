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
@property (nonatomic, retain) NSNumber *bikerId;
@property (nonatomic, retain) NSString *bikerFirstName;
@property (nonatomic, retain) NSString *bikerLastName;
@property (nonatomic, retain) NSString *bikerStreet;
@property (nonatomic, retain) NSNumber *bikerPostalCode;
@property (nonatomic, retain) NSString *bikerCity;
@property (nonatomic, retain) NSString *bikerEmailAddress;
@end

@interface BBApiActivationOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiActivationResponse *response;
@end