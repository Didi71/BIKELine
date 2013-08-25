//
//  BBApiGetPricesOperation.h
//  BIKELine
//
//  Created by Christoph Lückler on 23.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "Jastor.h"
#import "BBApiAbstractOperation.h"
#import "JSONKit.h"

@interface BBApiGetPricesResponse : Jastor
@property (nonatomic, retain) NSNumber *errorCode;
@property (nonatomic, retain) NSArray *prices;
@end

@interface BBPrice : Jastor
@property (nonatomic, retain) NSNumber *timeWon;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *sponsorName;
@property (nonatomic, retain) NSString *sponsorCity;
@property (nonatomic, retain) NSString *eventName;
@end

@interface BBApiGetPricesOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiGetPricesResponse *response;
@end