//
//  BBApi.m
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApi.h"

@implementation BBApi
@synthesize queue;

static BBApi *sharedInstance;

const float kQueueCheckTimeIntervall = 15.0;
const int kMaxQueueObjects = 15;

const int kMaxRequestRetry = 5;

NSString *kRequestStatusOK = @"OK";
NSString *kRequestStatusNOK = @"NOK";


+ (BBApi *)sharedAPI {
	return sharedInstance ?: [self new];
}

- (id)init {
	if (sharedInstance) {
	} else if ((self = sharedInstance = [super init])) {
        queue = [[NSOperationQueue alloc] init];
        [queue setMaxConcurrentOperationCount:1];
        queueCheckTimer = [NSTimer scheduledTimerWithTimeInterval:kQueueCheckTimeIntervall target:self selector:@selector(cleanUpQueue) userInfo:nil repeats:YES];
	}
	return sharedInstance;
}

- (void)dealloc {
    if (queueCheckTimer) {
        [queueCheckTimer invalidate];
    }
}


#pragma mark
#pragma mark - API-Queue-Check methods

- (void)cleanUpQueue {
    if (queue.operationCount > kMaxQueueObjects) {
        [self cleanQueue];
    }
    
    if (queue.operationCount == 0 && [UIApplication sharedApplication].networkActivityIndicatorVisible == YES) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

- (void)cleanQueue {
    [queue cancelAllOperations];
    [queue waitUntilAllOperationsAreFinished];
}


#pragma mark
#pragma mark - Private methods

- (BBApiLoginOperation *)loginUserWitheMail:(NSString *)eMail {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:eMail, @"emailAddress", nil];
    return [[BBApiLoginOperation alloc] initWithPath:@"reloginBiker.php" andParameters:parameters];
}

- (BBApiRegistrationOperation *)registerUserWithFirstName:(NSString *)first lastName:(NSString *)last street:(NSString *)street postalCode:(NSString *)code city:(NSString *)city andEMail:(NSString *)eMail {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: first, @"firstName",
                                                                           last, @"lastName",
                                                                           street, @"street",
                                                                           code, @"postalCode",
                                                                           city, @"city",
                                                                           eMail, @"emailAddress", nil];
    
    return [[BBApiRegistrationOperation alloc] initWithPath:@"loginBiker.php" andParameters:parameters];
}

- (BBApiActivationOperation *)activateUserWithId:(NSNumber *)userId andActivationCode:(NSNumber *)code {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: userId, @"id",
                                                                           code, @"PIN", nil];
    return [[BBApiActivationOperation alloc] initWithPath:@"activateBiker.php" andParameters:parameters];
}

- (BBApiCheckinOperation *)checkinAtPoin:(NSNumber *)pointId withUserId:(NSNumber *)userId andTeamId:(NSNumber *)teamId {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: userId, @"bikerId",
                                                                           pointId, @"checkPointId",
                                                                           teamId, @"teamBikerId", nil];
    return [[BBApiCheckinOperation alloc] initWithPath:@"checkIn.php" andParameters:parameters];
}



@end
