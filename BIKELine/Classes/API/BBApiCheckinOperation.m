//
//  BBApiCheckinOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiCheckinOperation.h"

@implementation BBApiCheckinPrice
@synthesize timeWon, description, eventName, sponsorCity, sponsorName;
@end

@implementation BBApiCheckinResponse
@synthesize errorCode, bikebirds, bikebirdsFirstCheckIn, bikebirdsFirstCheckPointCheckIn, bikebirdsOld, checkPointCity, checkPointName, date, price, rank;
@end

@implementation BBApiCheckinOperation
@synthesize response;
- (void)requestFinishedWithResult:(NSString *)jsonResult {
    response = [[BBApiCheckinResponse alloc] initWithDictionary:[jsonResult objectFromJSONString]];
}
@end
