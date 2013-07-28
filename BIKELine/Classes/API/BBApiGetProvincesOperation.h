//
//  BBApiGetProvincesOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiGetProvincesResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@property (nonatomic, retain) NSArray *provinces;
@end

@interface BBApiGetProvincesOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiGetProvincesResponse *response;
@end