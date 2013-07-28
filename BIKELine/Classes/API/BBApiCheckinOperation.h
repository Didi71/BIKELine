//
//  BBApiCheckinOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiCheckinResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@property (nonatomic, retain) NSNumber *bikebirdsFirstCheckIn;
@property (nonatomic, retain) NSNumber *bikebirdsOld;
@property (nonatomic, retain) NSNumber *bikebirdsFirstCheckPointCheckIn;
@property (nonatomic, retain) NSNumber *bikebirds;
@property (nonatomic, retain) NSNumber *date;
@property (nonatomic, retain) NSNumber *rank;
@property (nonatomic, retain) NSString *checkPointName;
@property (nonatomic, retain) NSString *checkPointCity;
@property (nonatomic, retain) NSString *price;
@end

@interface BBApiCheckinOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiCheckinResponse *response;
@end
