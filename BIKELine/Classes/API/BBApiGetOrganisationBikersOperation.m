//
//  BBApiGetOrganisationBikersOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiGetOrganisationBikersOperation.h"

@implementation BBApiGetOrganisationBikersResponse
@synthesize errorCode, bikers;

+ (Class)bikers_class {
    return [BBOrganisationBiker class];
}

@end

@implementation BBOrganisationBiker
@synthesize bikerId, firstName, lastName, city;
@end

@implementation BBApiGetOrganisationBikersOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiGetOrganisationBikersResponse alloc] init];
    
    response.errorCode = [[jsonResult objectFromJSONString] objectForKey:@"errorCode"];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[[[jsonResult objectFromJSONString] objectForKey:@"bikers"] count]];
    for (NSDictionary *dict in [[jsonResult objectFromJSONString] objectForKey:@"bikers"]) {
        BBOrganisationBiker *biker = [[BBOrganisationBiker alloc] init];
        biker.bikerId = [dict objectForKey:@"id"];
        biker.firstName = [dict objectForKey:@"firstName"];
        biker.lastName = [dict objectForKey:@"lastName"];
        biker.city = [dict objectForKey:@"city"];
        
        [arr addObject:biker];
    }
    response.bikers = arr;
}
@end