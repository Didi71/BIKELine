//
//  CheckpointAnnotation.m
//  BIKELine
//
//  Created by Christoph Lückler on 25.08.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "CheckpointAnnotation.h"

@implementation CheckpointAnnotation
@synthesize coordinate, title, subtitle, checkpointId;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coords {
    self = [super init];
    if (self) {
        coordinate = coords;
    }
    
    return self;
}

@end
