//
//  NSUserDefaults+BIKELine.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "NSUserDefaults+BIKELine.h"

@implementation NSUserDefaults (BIKELine)

- (NSString *)eMail {
	return [[NSUserDefaults standardUserDefaults] objectForKey:@"eMail"];
}

- (void)setEMail:(NSString *)eMail {
	[[NSUserDefaults standardUserDefaults] setObject:eMail forKey:@"eMail"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
