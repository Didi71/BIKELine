//
//  CheckpointAnnotation.h
//  BIKELine
//
//  Created by Christoph Lückler on 25.08.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CheckpointAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, readwrite, copy) NSString *subtitle;
@property (nonatomic, retain) NSNumber *checkpointId;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coords;

@end
