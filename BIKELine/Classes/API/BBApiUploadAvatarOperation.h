//
//  BBApiUploadAvatarOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiUploadAvatarResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@end

@interface BBApiUploadAvatarOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiUploadAvatarResponse *response;
@end