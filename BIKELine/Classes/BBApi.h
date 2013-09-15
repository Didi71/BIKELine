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
#import "BBApiGetProvincesOperation.h"
#import "BBApiGetOrganisationsOperation.h"
#import "BBApiGetOrganisationBikersOperation.h"
#import "BBApiUploadAvatarOperation.h"
#import "BBApiGetCheckinsOperation.h"
#import "BBApiGetTeamCheckinsOperation.h"
#import "BBApiUpdateBikerInfoOperation.h"

#define SharedAPI [BBApi sharedAPI]

@interface BBApi : NSObject {
    NSTimer *queueCheckTimer;
}

@property (nonatomic, retain) NSOperationQueue *queue;


+ (BBApi *)sharedAPI;
- (void)cleanQueue;

- (BBApiLoginOperation *)loginUserWitheMail:(NSString *)eMail;
- (BBApiRegistrationOperation *)registerBikerWithInfo:(BikerMO *)biker;
- (BBApiUpdateBikerInfoOperation *)updateBikerInfo:(BikerMO *)biker;
- (BBApiActivationOperation *)activateUserWithId:(NSNumber *)userId andActivationCode:(NSNumber *)code;
- (BBApiCheckinOperation *)checkinAtPoin:(NSNumber *)pointId withUserId:(NSNumber *)userId teamId:(NSNumber *)teamId andPIN:(NSNumber *)pin;
- (BBApiGetPricesOperation *)getPricesForUserId:(NSNumber *)userId;
- (BBApiGetCheckPointsOperation *)getCheckPointsWithLatitude:(double)lat andLongitude:(double)lon;
- (BBApiGetCheckinsOperation *)getCheckInsWithBikerId:(NSNumber *)bikerId andPin:(NSNumber *)pin;
- (BBApiGetTeamCheckinsOperation *)getTeamCheckInsWithTeamId:(NSNumber *)teamId andPin:(NSNumber *)pin;
- (BBApiGetProvincesOperation *)getProvinces;
- (BBApiGetOrganisationsOperation *)getOrganisationsForProvince:(NSString *)prov;
- (BBApiGetOrganisationBikersOperation *)getBikersInOrganisation:(NSNumber *)orgId;
- (BBApiUploadAvatarOperation *)uploadAvatar:(NSData *)dataImg forBikerId:(NSNumber *)bikerId andPIN:(NSNumber *)pin;

- (void)displayError:(NSNumber *)errorCode;

@end
