//
//  BBApiUpdateBikerInfoOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 15.09.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiUpdateBikerInfoResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@end

@interface BBApiUpdateBikerInfoOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiUpdateBikerInfoResponse *response;
@end
