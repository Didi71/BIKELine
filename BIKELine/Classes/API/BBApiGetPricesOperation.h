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
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *error;
@property (nonatomic, retain) NSArray *prices;
@end

@interface BBPrice : Jastor
@property (nonatomic, retain) NSNumber *timeWon;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *city;
@end

@interface BBApiGetPricesOperation : BBApiAbstractOperation
@property (nonatomic, retain) BBApiGetPricesResponse *response;
@end