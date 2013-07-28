//
//  BBApiGetOrganisationsOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiGetOrganisationsResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@property (nonatomic, retain) NSArray *orgs;
@end

@interface BBOrganisation : Jastor
@property (nonatomic, retain) NSNumber *organisationId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *postalCode;
@property (nonatomic, retain) NSString *city;
@end

@interface BBApiGetOrganisationsOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiGetOrganisationsResponse *response;
@end