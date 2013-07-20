//
//  AccountService.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SharedAccountService [AccountSyncService sharedService]

@interface AccountService : NSObject {
    
}

+ (AccountService *)sharedService;

@end
