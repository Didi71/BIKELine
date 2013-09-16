//
//  MapViewController.m
//  BIKELine
//
//  Created by Christoph Lückler on 20.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//

#import "MapViewController.h"
#import "BBApi.h"
#import "CheckpointAnnotation.h"

@implementation MapViewController

const int kUpdateCheckpointTimerIntervall = 2.0;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = NSLocalizedString(@"mapViewTitle", @"");
    }
    return self;
}


#pragma mark
#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Configure Map
    map.mapType = MKMapTypeStandard;
    map.showsUserLocation = YES;
    map.delegate = self;
    
    // Show progressHud because we have no correct position on startup
    [self _showProgressHudWithMessage:NSLocalizedString(@"progressAcquiringPosition", @"")];
}


#pragma mark
#pragma mark - Notifications

- (void)updateTimerFinished {
    [updateCheckpointsTimer invalidate];
    [self getCheckPoints];
    
    [self centerOnUserLocation];
}


#pragma mark
#pragma mark - Protected methods

- (void)_showProgressHudWithMessage:(NSString *)message {
    // Setup progress hud
    if (!progressHud) {
        progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        progressHud.mode = MBProgressHUDModeIndeterminate;
        progressHud.removeFromSuperViewOnHide = YES;
    }
    
    if (![progressHud.superview isEqual:self.view]) {
        [self.view addSubview:progressHud];
    }
    
    [progressHud setLabelText:message];
    [progressHud show:YES];
}

- (void)_hideProgressHud {
    [progressHud hide:YES];
}


#pragma mark 
#pragma mark - Private methods

- (void)getCheckPoints {
    
    if (!result_checkpoints) {
        [self _showProgressHudWithMessage:NSLocalizedString(@"progressLoadCheckPointsLabel", @"")];
    }
    
    BBApiGetCheckPointsOperation *op = [SharedAPI getCheckPointsWithLatitude: map.userLocation.coordinate.latitude
                                                                andLongitude: map.userLocation.coordinate.longitude];
    __block BBApiGetCheckPointsOperation *wop = op;
    
    [op setCompletionBlock:^{
        if ([wop.response.errorCode integerValue] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SharedAPI displayError:wop.response.errorCode];
                [self _hideProgressHud];
            });
            return;
        }
        
        if (!result_checkpoints) {
            result_checkpoints = [[NSMutableArray alloc] initWithArray:wop.response.checkPoints];
        } else {
            [result_checkpoints removeAllObjects];
            [result_checkpoints addObjectsFromArray:wop.response.checkPoints];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _hideProgressHud];
            [self loadCheckpointsToMap];
        });
    }];
    
    [SharedAPI.queue addOperation:op];
}

- (void)loadCheckpointsToMap {
    if (![NSThread isMainThread] || result_checkpoints == nil || [result_checkpoints count] == 0) {
        return;
    }
    
    // Remove all annotations
    NSMutableArray *toBeRemovedAnnotations = [[NSMutableArray alloc] initWithCapacity:[map.annotations count]];
    for (id <MKAnnotation> annotation in map.annotations) {
        if (![annotation isKindOfClass:[MKUserLocation class]]) {
            [toBeRemovedAnnotations addObject:annotation];
        }
    }
    
    [map removeAnnotations:toBeRemovedAnnotations];
    
    // Add new annotations
    for (BBCheckPoint *checkpoint in result_checkpoints) {
        CheckpointAnnotation *annotiation = [[CheckpointAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([checkpoint.latitude doubleValue], [checkpoint.longitude doubleValue])];
        annotiation.title = checkpoint.name;
        annotiation.subtitle = checkpoint.eventName;
        annotiation.checkpointId = checkpoint.checkPointId;
        
        [map addAnnotation:annotiation];
    }
}

- (void)centerOnUserLocation {
    MKCoordinateRegion region;
    region.center.latitude = map.userLocation.coordinate.latitude;
    region.center.longitude = map.userLocation.coordinate.longitude;
    region.span.latitudeDelta = 1.0;
    region.span.longitudeDelta = 1.0;
    
    [map setRegion:[map regionThatFits:region] animated:YES];
}


#pragma mark
#pragma mark - MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return NULL;
	}
    
    // Custom pin's
	MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotation.title];
    
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title];
    } else {
        pinView.annotation = annotation;
    }
    
    [pinView setCanShowCallout:YES];
    
	return pinView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (updateCheckpointsTimer && updateCheckpointsTimer.isValid) {
        [updateCheckpointsTimer invalidate];
    } 
    
    updateCheckpointsTimer = [NSTimer scheduledTimerWithTimeInterval: kUpdateCheckpointTimerIntervall
                                                              target: self
                                                            selector: @selector(updateTimerFinished)
                                                            userInfo: nil
                                                             repeats: NO];
}


@end
