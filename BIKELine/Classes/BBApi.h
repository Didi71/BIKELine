//
//  BBApi.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBApi : NSObject {
    NSTimer *queueCheckTimer;
}

@property (nonatomic, retain) NSOperationQueue *queue;

+ (BBApi *)sharedAPI;

- (void)cleanQueue;



@end
