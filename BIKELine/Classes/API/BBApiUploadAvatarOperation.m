//
//  BBApiUploadAvatarOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiUploadAvatarOperation.h"

@implementation BBApiUploadAvatarResponse
@synthesize errorCode;
@end

@implementation BBApiUploadAvatarOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiUploadAvatarResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
}
@end