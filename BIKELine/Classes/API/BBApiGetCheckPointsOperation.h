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
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSArray *checkPoints;
@end

@interface BBCheckPoint : Jastor
@property (nonatomic, retain) NSNumber *eventId;
@property (nonatomic, retain) NSString *eventName;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSNumber *eventStart;
@property (nonatomic, retain) NSNumber *eventEnd;
@property (nonatomic, retain) NSNumber *isHot;
@end

@interface BBApiGetCheckPointsOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiGetCheckPointsResponse *response;
@end