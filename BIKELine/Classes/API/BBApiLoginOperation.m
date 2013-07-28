//
//  BBApiLoginOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiLoginOperation.h"

@implementation BBApiLoginResponse
@synthesize errorCode, bikerId, bikerFirstName, pin;
@end

@implementation BBApiLoginOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiLoginResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
    
    // Because API delivers some wired JSON-Key's and we have to rename it
    response.pin = [[jsonResult objectFromJSONString] objectForKey:@"PIN"];
}
@end
