//
//  BBApiGetPricesOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 23.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiGetPricesOperation.h"

@implementation BBApiGetPricesResponse
@synthesize status, prices, error;

+ (Class)prices_class {
    return [BBPrice class];
}

@end

@implementation BBPrice
@synthesize timeWon, description, name, city;
@end

@implementation BBApiGetPricesOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiGetPricesResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
}
@end