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
    return [[BBApiLoginOperation alloc] initWithPath:@"loginBiker.php" andParameters:parameters];
}

- (BBApiRegistrationOperation *)registerUserWithFirstName:(NSString *)first lastName:(NSString *)last street:(NSString *)street postalCode:(NSString *)code city:(NSString *)city eMail:(NSString *)eMail andSex:(BOOL)isMale {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: first, @"firstName",
                                                                           last, @"lastName",
                                                                           street, @"street",
                                                                           code, @"postalCode",
                                                                           city, @"city",
                                                                           eMail, @"emailAddress",
                                                                           (isMale == YES ? @"male" : @"female"), @"sex", nil];
    
    return [[BBApiRegistrationOperation alloc] initWithPath:@"registerBiker.php" andParameters:parameters];
}

- (BBApiActivationOperation *)activateUserWithId:(NSNumber *)userId andActivationCode:(NSNumber *)code {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: userId, @"id",
                                                                           code, @"PIN", nil];
    return [[BBApiActivationOperation alloc] initWithPath:@"activateBiker.php" andParameters:parameters];
}

- (BBApiCheckinOperation *)checkinAtPoin:(NSNumber *)pointId withUserId:(NSNumber *)userId teamId:(NSNumber *)teamId andPIN:(NSNumber *)pin {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: userId, @"bikerId",
                                                                           pin, @"PIN",
                                                                           pointId, @"checkPointId",
                                                                           teamId, @"teamBikerId", nil];
    return [[BBApiCheckinOperation alloc] initWithPath:@"checkIn.php" andParameters:parameters];
}

- (BBApiGetPricesOperation *)getPricesForUserId:(NSNumber *)userId {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:userId, @"bikerId", nil];
    return [[BBApiGetPricesOperation alloc] initWithPath:@"getPrices.php" andParameters:parameters];
}

- (BBApiGetCheckPointsOperation *)getCheckPointsWithLatitude:(double)lat andLongitude:(double)lon {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithDouble:lat], @"latitude",
                                                                           [NSNumber numberWithDouble:lon], @"longitude", nil];
    return [[BBApiGetCheckPointsOperation alloc] initWithPath:@"getCheckPoints.php" andParameters:parameters];
}


#pragma mark
#pragma mark - Error Handling

- (void)displayError:(NSNumber *)errorCode {
    if (!errorCode) {
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"errorAlertViewTitle", @"")
                                                    message: [self getErrorMessageForCode:errorCode]
                                                   delegate: nil
                                          cancelButtonTitle: NSLocalizedString(@"buttonOkTitle", @"")
                                          otherButtonTitles: nil];
    
    [alert show];
}

- (NSString *)getErrorMessageForCode:(NSNumber *)errCode {
    switch ([errCode intValue]) {
        case 20:
            return NSLocalizedString(@"errorInvalidCheckpointText", @"");
            break;
            
        case 30:
            return NSLocalizedString(@"errorInvalidPINText", @"");
            break;
            
        case 31:
            return NSLocalizedString(@"errorInvalidEMailText", @"");
            break;
            
        case 32:
            return NSLocalizedString(@"errorUnknownEMailText", @"");
            break;
            
        default:
            return [NSString stringWithFormat:NSLocalizedString(@"errorDefaultText", @""), errCode];
            break;
    }
}

@end
