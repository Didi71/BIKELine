//
//  BLUtils.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLUtils : NSObject

+ (UIImage *)resizeImage:(UIImage *)originalImg toSize:(CGSize)newSize withCompression:(float)compression;

@end
