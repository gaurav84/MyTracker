//
//  CoreLocationFactory.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 30/04/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

// API Files
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// Custom Files
#import "LocationVO.h"

@protocol CoreLocationManagerDelegate <NSObject>

-(void)didReceiveLocation:(LocationVO *)locationVO;
-(void)didFailWithError:(NSError *)error;

@end

@interface CoreLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) id <CoreLocationManagerDelegate> delegate;

-(void)startLocationService;
+(CoreLocationManager *)getInstance;

@end
