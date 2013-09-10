//
//  NSUserDefaults+BIKELine.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BikerMO.h"

#define BLStandardUserDefaults [NSUserDefaults standardUserDefaults]

@interface NSUserDefaults (BIKELine)

@property (nonatomic, retain) BikerMO *biker;
@property (nonatomic, assign) BOOL qrReaderWasAlreadyInUse;

@end
