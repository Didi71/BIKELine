//
//  BBApiRegistrationOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiRegistrationOperation.h"

@implementation BBApiRegistrationResponse
@synthesize errorCode, bikerFirstName, bikerId, pin;
@end

@implementation BBApiRegistrationOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiRegistrationResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
    
    // Because API delivers some wired JSON-Key's and we have to rename it
    response.pin = [[jsonResult objectFromJSONString] objectForKey:@"PIN"];
}
@end
