//
//  BBApiGetCheckinsOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 25.08.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiGetCheckinsOperation.h"

@implementation BBApiGetCheckinsResponse
@synthesize checkIns, errorCode;

+ (Class)checkIns_class {
    return [BBCheckIn class];
}

@end

@implementation BBCheckIn
@synthesize date, bikebirds, checkPointCity, checkPointId, checkPointName;
@end

@implementation BBApiGetCheckinsOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiGetCheckinsResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
}
@end