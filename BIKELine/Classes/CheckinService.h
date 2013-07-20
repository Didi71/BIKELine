//
//  CheckinService.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SharedCheckinService [CheckinService sharedService]

@interface CheckinService : NSObject {
    
}

+ (CheckinService *)sharedService;

@end
