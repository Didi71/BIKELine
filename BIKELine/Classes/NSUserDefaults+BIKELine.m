//
//  NSUserDefaults+BIKELine.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "NSUserDefaults+BIKELine.h"

@implementation NSUserDefaults (BIKELine)

- (BikerMO *)biker {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"biker"];
    
    if (dict) {
        return [[BikerMO alloc] initWithDictionary:dict];
    } else {
        return [[BikerMO alloc] init];
    }
}

- (void)setBiker:(BikerMO *)biker {
	[[NSUserDefaults standardUserDefaults] setObject:biker.dictionary forKey:@"biker"];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    if (biker == nil) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [documentPath stringByAppendingPathComponent:@"Avatar.jpeg"];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

- (BOOL)qrReaderWasAlreadyInUse {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"qrReaderWasAlreadyInUse"];
}

- (void)setQrReaderWasAlreadyInUse:(BOOL)qrReaderWasAlreadyInUse {
    [[NSUserDefaults standardUserDefaults] setBool:qrReaderWasAlreadyInUse forKey:@"qrReaderWasAlreadyInUse"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
