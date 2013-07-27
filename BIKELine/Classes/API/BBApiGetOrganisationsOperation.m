//
//  BBApiGetOrganisationsOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiGetOrganisationsOperation.h"

@implementation BBApiGetOrganisationsResponse
@synthesize errorCode, orgs;

+ (Class)orgs_class {
    return [BBOrganisation class];
}

@end

@implementation BBOrganisation
@synthesize organisationId, name, postalCode, city;
@end

@implementation BBApiGetOrganisationsOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiGetOrganisationsResponse alloc] init];
    
    response.errorCode = [[jsonResult objectFromJSONString] objectForKey:@"errorCode"];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[[[jsonResult objectFromJSONString] objectForKey:@"orgs"] count]];
    for (NSDictionary *dict in [[jsonResult objectFromJSONString] objectForKey:@"orgs"]) {
        BBOrganisation *org = [[BBOrganisation alloc] init];
        org.organisationId = [dict objectForKey:@"id"];
        org.name = [dict objectForKey:@"name"];
        org.postalCode = [dict objectForKey:@"postalCode"];
        org.city = [dict objectForKey:@"city"];
        
        [arr addObject:org];
    }
    response.orgs = arr;
}
@end