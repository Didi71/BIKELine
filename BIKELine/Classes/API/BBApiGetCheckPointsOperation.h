//
//  BBApiGetCheckPointsOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 23.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiGetCheckPointsResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@property (nonatomic, retain) NSArray *checkPoints;
@end

@interface BBCheckPoint : Jastor
@property (nonatomic, retain) NSNumber *checkPointId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSNumber *isHot;
@property (nonatomic, retain) NSString *eventName;
@property (nonatomic, retain) NSNumber *eventStart;
@property (nonatomic, retain) NSNumber *eventEnd;
@end

@interface BBApiGetCheckPointsOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiGetCheckPointsResponse *response;
@end