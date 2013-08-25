//
//  BBApiGetTeamCheckinsOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 25.08.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiGetTeamCheckinsResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@property (nonatomic, retain) NSString *teamFirstName;
@property (nonatomic, retain) NSString *teamLastName;
@property (nonatomic, retain) NSString *teamCity;
@property (nonatomic, retain) NSNumber *teamBikebirds;
@property (nonatomic, retain) NSArray *teamCheckIns;
@end

@interface BBTeamCheckIn : Jastor
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSNumber *bikebirds;
@property (nonatomic, retain) NSNumber *lastCheckInDate;
@end

@interface BBApiGetTeamCheckinsOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiGetTeamCheckinsResponse *response;
@end