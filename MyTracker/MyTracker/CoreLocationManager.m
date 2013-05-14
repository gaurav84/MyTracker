//
//  CoreLocationFactory.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 30/04/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CoreLocationManager.h"

@implementation CoreLocationManager

+(CoreLocationManager *)getInstance {
    static CoreLocationManager *instance = nil;
    static dispatch_once_t obj;
    dispatch_once(&obj, ^{
        instance = [[self alloc] init];
        instance.locationManager = [[CLLocationManager alloc] init];
    });
    return instance;
}

-(void)startLocationService {
    self.locationManager.delegate = self;
    if([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
    else {
        AppLog(@"Location Services are not enabled");
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    AppLog(@"%@", [NSString stringWithFormat:@"Latitude: %f, Longitude: %f", [[locations lastObject] coordinate].latitude, [[locations lastObject] coordinate].longitude]);
    
    LocationVO *locationVO = [[LocationVO alloc] init];
    locationVO.latitude = [[locations lastObject] coordinate].latitude;
    locationVO.longitude = [[locations lastObject] coordinate].longitude;
    [self.delegate didReceiveLocation:locationVO];
    
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    AppLog(@"[CoreLocationManager] Error: %@", [error localizedDescription]);
    
    [self.delegate didFailWithError:error];
}

@end
