//
//  BBApiActivationOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiActivationOperation.h"

@implementation BBApiActivationResponse
@synthesize errorCode;
@end

@implementation BBApiActivationOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiActivationResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
}
@end