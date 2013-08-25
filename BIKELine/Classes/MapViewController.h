//
//  MapViewController.h
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MBProgressHUD.h"

@interface MapViewController : UIViewController <MKMapViewDelegate> {
    IBOutlet MKMapView *map;
    IBOutlet MBProgressHUD *progressHud;
    
    __block NSMutableArray *response_checkpoints;
    
    NSTimer *updateCheckpointsTimer;
}

@end
