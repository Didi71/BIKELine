//
//  BBApiGetTeamCheckinsOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 25.08.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiGetTeamCheckinsOperation.h"

@implementation BBApiGetTeamCheckinsResponse
@synthesize errorCode, teamBikebirds, teamCheckIns, teamCity, teamFirstName, teamLastName;

+ (Class)teamCheckIns_class {
    return [BBTeamCheckIn class];
}

@end

@implementation BBTeamCheckIn
@synthesize bikebirds, city, firstName, lastCheckInDate, lastName;
@end

@implementation BBApiGetTeamCheckinsOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiGetTeamCheckinsResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
}
@end