//
//  BBApiUpdateBikerInfoOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 15.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiUpdateBikerInfoOperation.h"

@implementation BBApiUpdateBikerInfoResponse
@synthesize errorCode;
@end

@implementation BBApiUpdateBikerInfoOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiUpdateBikerInfoResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
}
@end