//
//  BLScrollView.m
//  BIKELine
//
//  Created by Christoph Lückler on 27.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "BLScrollView.h"

@implementation BLScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.superview touchesBegan:touches withEvent:event];
}

@end
