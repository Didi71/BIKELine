//
//  NSUserDefaults+BIKELine.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BLStandardUserDefaults [NSUserDefaults standardUserDefaults]

@interface NSUserDefaults (BIKELine)

@property (nonatomic, retain) NSString *eMail;

@end
