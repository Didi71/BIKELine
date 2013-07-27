//
//  BBApiGetProvincesOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiGetProvincesOperation.h"

@implementation BBApiGetProvincesResponse
@synthesize errorCode, provinces;

+ (Class)provinces_class {
    return [NSString class];
}

@end

@implementation BBApiGetProvincesOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiGetProvincesResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
}
@end