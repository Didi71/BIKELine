//
//  BBApiAbstractOperation.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BBApiAbstractOperation.h"
#import "AFNetworking.h"
#import "JSONKit.h"

@implementation BBApiAbstractOperation
@synthesize pathUrlString, parameters;

- (id)initWithPath:(NSString *)url andParameters:(NSDictionary *)params {
    self = [super init];
    if (self) {
        pathUrlString = url;
        parameters = params;
    }
    return self;
}

- (void)main {
//    Reachability *curReach = [Reachability reachabilityWithHostName: @"app.mysms.com"];
//    if ([curReach currentReachabilityStatus] == NotReachable) {
//        NSLog(@"Network-ERROR: app.mysms.com not reachable");
//        [self requestFinishedWithResult:@"{\"errorCode\":99}"];
//        return;
//    }
    
    NSLog(@"URL = %@", [BIKEBIRD_API_BASE_URL stringByAppendingPathComponent:pathUrlString]);
    NSLog(@"PARAMETERS = %@", parameters);    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSMutableURLRequest *jsonRequest = [self configureRequestForPath:pathUrlString withParameters:parameters];
    
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = nil;
    
    for (NSInteger i=0; i < 5; i++) {
        data = [NSURLConnection sendSynchronousRequest:jsonRequest returningResponse:&response error:&error];
        
        if (!error) {
            break;
        }
        
        sleep(1.0);
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (error) {
        [self requestFinishedWithResult:@"{\"errorCode\":99}"];
        return;
    } else {
        NSError *parseError = nil;
        NSDictionary *responseDic = [data objectFromJSONDataWithParseOptions:JKParseOptionValidFlags error:&parseError];
        
        NSLog(@"RESPONSE = %@", responseDic);
        
        if (parseError) {
            [self requestFinishedWithResult:[NSString stringWithFormat:@"{\"errorCode\":%d}", (11000 + abs(parseError.code))]];
            return;
        } 
        
        if ([responseDic JSONString].length != 0 || [[responseDic JSONString] rangeOfString:@"<!DOCTYPE html>"].location == NSNotFound) {
            [self requestFinishedWithResult:[responseDic JSONString]];
        } else {
            [self requestFinishedWithResult:@"{\"errorCode\":99}"];
        }
    }
}

- (NSMutableURLRequest *)configureRequestForPath:(NSString *)path withParameters:(NSDictionary *)params {
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BIKEBIRD_API_BASE_URL]];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:path parameters:params];
    
    // Configure Request
    [request setTimeoutInterval:30.0];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setValue:@"15" forHTTPHeaderField:@"Keep-Alive"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    
    return request;
}

- (void)requestFinishedWithResult:(NSString *)jsonResult {
    // Should be overridden by child class
}

@end
