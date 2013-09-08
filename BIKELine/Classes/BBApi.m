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


+ (BBApi *)sharedAPI {
	return sharedInstance ?: [self new];
}

- (id)init {
	if (sharedInstance) {
	} else if ((self = sharedInstance = [super init])) {
        queue = [[NSOperationQueue alloc] init];
        [queue setMaxConcurrentOperationCount:1];
        queueCheckTimer = [NSTimer scheduledTimerWithTimeInterval: kQueueCheckTimeIntervall
                                                           target: self
                                                         selector: @selector(cleanUpQueue)
                                                         userInfo: nil
                                                          repeats: YES];
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
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: eMail, @"bikerEmailAddress",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiLoginOperation alloc] initWithPath:@"loginBiker.php" andParameters:parameters];
}

- (BBApiRegistrationOperation *)registerBikerWithInfo:(BikerMO *)biker {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: biker.firstName, @"bikerFirstName",
                                                                           biker.lastName, @"bikerLastName",
                                                                           biker.eMail, @"bikerEmailAddress",
                                                                           biker.city, @"bikerCity",
                                                                           ([biker.sex intValue] == kBikerSexMale ? @"male" : @"female"), @"bikerSex",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    
    return [[BBApiRegistrationOperation alloc] initWithPath:@"registerBiker.php" andParameters:parameters];
}

- (BBApiActivationOperation *)activateUserWithId:(NSNumber *)userId andActivationCode:(NSNumber *)code {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: userId, @"bikerId",
                                                                           code, @"PIN",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiActivationOperation alloc] initWithPath:@"activateBiker.php" andParameters:parameters];
}

- (BBApiCheckinOperation *)checkinAtPoin:(NSNumber *)pointId withUserId:(NSNumber *)userId teamId:(NSNumber *)teamId andPIN:(NSNumber *)pin {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: BIKEBIRD_API_KEY, @"APIKey",
                                                                           userId, @"bikerId",
                                                                           pin, @"PIN",
                                                                           pointId, @"checkPointId",
                                                                           teamId, @"teamId", nil];
    return [[BBApiCheckinOperation alloc] initWithPath:@"checkIn.php" andParameters:parameters];
}

- (BBApiGetPricesOperation *)getPricesForUserId:(NSNumber *)userId {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: userId, @"bikerId",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiGetPricesOperation alloc] initWithPath:@"getPrices.php" andParameters:parameters];
}

- (BBApiGetCheckPointsOperation *)getCheckPointsWithLatitude:(double)lat andLongitude:(double)lon {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithDouble:lat], @"latitude",
                                                                           [NSNumber numberWithDouble:lon], @"longitude",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiGetCheckPointsOperation alloc] initWithPath:@"getCheckPoints.php" andParameters:parameters];
}

- (BBApiGetCheckinsOperation *)getCheckInsWithBikerId:(NSNumber *)bikerId andPin:(NSNumber *)pin {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: bikerId, @"bikerId",
                                                                           pin, @"PIN",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiGetCheckinsOperation alloc] initWithPath:@"getCheckIns.php" andParameters:parameters];
}

- (BBApiGetTeamCheckinsOperation *)getTeamCheckInsWithTeamId:(NSNumber *)teamId andPin:(NSNumber *)pin {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: teamId, @"teamId",
                                                                           pin, @"PIN",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiGetTeamCheckinsOperation alloc] initWithPath:@"getTeamCheckIns.php" andParameters:parameters];
}

- (BBApiGetProvincesOperation *)getProvinces {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiGetProvincesOperation alloc] initWithPath:@"getProvinces.php" andParameters:parameters];
}

- (BBApiGetOrganisationsOperation *)getOrganisationsForProvince:(NSString *)prov {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: prov, @"province",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiGetOrganisationsOperation alloc] initWithPath:@"getOrgs.php" andParameters:parameters];
}

- (BBApiGetOrganisationBikersOperation *)getBikersInOrganisation:(NSNumber *)orgId {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: orgId, @"orgId",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiGetOrganisationBikersOperation alloc] initWithPath:@"getBikers.php" andParameters:parameters];
}

- (BBApiUploadAvatarOperation *)uploadAvatar:(NSData *)dataImg forBikerId:(NSNumber *)bikerId andPIN:(NSNumber *)pin {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: dataImg, @"bikerImage",
                                                                           bikerId, @"bikerId",
                                                                           pin, @"PIN",
                                                                           BIKEBIRD_API_KEY, @"APIKey", nil];
    return [[BBApiUploadAvatarOperation alloc] initWithPath:@"uploadAvatar.php" andParameters:parameters];
}


#pragma mark
#pragma mark - Error Handling

- (void)displayError:(NSNumber *)errorCode {
    if (!errorCode) {
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil
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
