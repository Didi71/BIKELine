//
//  BBApi.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBApiLoginOperation.h"
#import "BBApiRegistrationOperation.h"
#import "BBApiActivationOperation.h"
#import "BBApiCheckinOperation.h"
#import "BBApiGetPricesOperation.h"
#import "BBApiGetCheckPointsOperation.h"

#define SharedAPI [BBApi sharedAPI]

@interface BBApi : NSObject {
    NSTimer *queueCheckTimer;
}

@property (nonatomic, retain) NSOperationQueue *queue;


+ (BBApi *)sharedAPI;
- (void)cleanQueue;

- (BBApiLoginOperation *)loginUserWitheMail:(NSString *)eMail;
- (BBApiRegistrationOperation *)registerBikerWithInfo:(BikerMO *)biker;
- (BBApiActivationOperation *)activateUserWithId:(NSNumber *)userId andActivationCode:(NSNumber *)code;
- (BBApiCheckinOperation *)checkinAtPoin:(NSNumber *)pointId withUserId:(NSNumber *)userId teamId:(NSNumber *)teamId andPIN:(NSNumber *)pin;
- (BBApiGetPricesOperation *)getPricesForUserId:(NSNumber *)userId;
- (BBApiGetCheckPointsOperation *)getCheckPointsWithLatitude:(double)lat andLongitude:(double)lon;

- (void)displayError:(NSNumber *)errorCode;

@end
