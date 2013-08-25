//
//  BBApiGetCheckinsOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 25.08.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiGetCheckinsResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@property (nonatomic, retain) NSArray *checkIns;
@end

@interface BBCheckIn : Jastor
@property (nonatomic, retain) NSNumber *date;
@property (nonatomic, retain) NSNumber *bikebirds;
@property (nonatomic, retain) NSString *checkPointName;
@property (nonatomic, retain) NSString *checkPointCity;
@property (nonatomic, retain) NSNumber *checkPointId;
@end

@interface BBApiGetCheckinsOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiGetCheckinsResponse *response;
@end