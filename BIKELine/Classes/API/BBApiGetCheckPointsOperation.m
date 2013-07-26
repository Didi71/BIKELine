//
//  BBApiGetCheckPointsOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 23.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiGetCheckPointsOperation.h"

@implementation BBApiGetCheckPointsResponse
@synthesize status, checkPoints;

+ (Class)checkPoints_class {
    return [BBCheckPoint class];
}

@end

@implementation BBCheckPoint
@synthesize eventId, eventName, eventEnd, eventStart, name, city, longitude, latitude, isHot;
@end

@implementation BBApiGetCheckPointsOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiGetCheckPointsResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
}
@end