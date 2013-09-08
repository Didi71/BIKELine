//
//  BLUtils.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_TALL_IPHONE() ([UIScreen mainScreen].bounds.size.height == 568)

@interface BLUtils : NSObject

+ (UIImage *)resizeImage:(UIImage *)originalImg toSize:(CGSize)newSize withCompression:(float)compression;
+ (NSDate *)convertFromApiDate:(NSNumber *)apiDate;

@end
