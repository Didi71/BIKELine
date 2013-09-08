//
//  BLUtils.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLUtils.h"

@implementation BLUtils

+ (UIImage *)resizeImage:(UIImage *)originalImg toSize:(CGSize)newSize withCompression:(float)compression {
    float scale = 1.0f;
    if (originalImg.size.width > newSize.width || originalImg.size.height > newSize.height) {
        scale = fminf(newSize.width / originalImg.size.width, newSize.height / originalImg.size.height);
    }
    
    CGSize fitSize = CGSizeMake(originalImg.size.width * scale, originalImg.size.height * scale);
    
    UIGraphicsBeginImageContext(fitSize);
	[originalImg drawInRect:CGRectMake(0, 0, fitSize.width, fitSize.height)];
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return [UIImage imageWithData:UIImageJPEGRepresentation(scaledImage, compression)];
}

+ (NSDate *)convertFromApiDate:(NSNumber *)apiDate {
    if ([apiDate stringValue].length >= 10) {
        return [NSDate dateWithTimeIntervalSince1970:[[[apiDate stringValue] substringToIndex:10] intValue]];
    } else {
        return nil;
    }
}

@end
