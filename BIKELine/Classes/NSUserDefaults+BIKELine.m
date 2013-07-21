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
        return nil;
    }
}

- (void)setBiker:(BikerMO *)biker {
	[[NSUserDefaults standardUserDefaults] setObject:biker.dictionary forKey:@"biker"];
	[[NSUserDefaults standardUserDefaults] synchronize]; 
}

@end
