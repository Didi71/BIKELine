//
//  CheckinService.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "CheckinService.h"

@implementation CheckinService

static CheckinService *sharedInstance;

+ (CheckinService *)sharedService {
	return sharedInstance ?: [self new];
}

- (id)init {
	if (sharedInstance) {
	} else if ((self = sharedInstance = [super init])) {
        // Do init stuff
	}
	return sharedInstance;
}

@end
