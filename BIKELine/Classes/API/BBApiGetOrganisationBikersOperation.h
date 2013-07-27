//
//  BBApiGetOrganisationBikersOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiGetOrganisationBikersResponse : Jastor
@property (nonatomic, retain) NSString *errorCode;
@property (nonatomic, retain) NSArray *bikers;
@end

@interface BBOrganisationBiker : Jastor
@property (nonatomic, retain) NSNumber *bikerId;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *city;
@end

@interface BBApiGetOrganisationBikersOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiGetOrganisationBikersResponse *response;
@end