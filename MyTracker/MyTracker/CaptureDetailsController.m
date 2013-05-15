//
//  ViewController.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 30/04/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CaptureDetailsController.h"
#import "CoreLocationManager.h"
#import "DateTimeUtil.h"
#import "DateTimeDayVO.h"
#import "CaptureDetailsVO.h"
#import "CoreDataUtil.h"
#import "AlertUtil.h"

@interface CaptureDetailsController ()

@end

@implementation CaptureDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setActivityIndicatorVisibility:NO];
    self.coreLocationManager = [CoreLocationManager getInstance];
    self.coreLocationManager.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    AppLog(@"Received memory warning!");
}

-(IBAction)captureDetails:(id)sender {
    [self setActivityIndicatorVisibility:YES];
    [self.coreLocationManager startLocationService];
}

#pragma mark CoreLocationManager delegate methods

-(void)didReceiveLocation:(LocationVO *)locationVO {
    // preparing the CaptureDetailsVO which will store the lat, lng, date, time, day, etc..
    CaptureDetailsVO *captureDetailsVO = [CaptureDetailsVO getInstance];
    captureDetailsVO.locationVO = locationVO;
    
    // getting the DateTimeDayVO
    DateTimeDayVO *dateTimeDayVO = [DateTimeUtil getDateTimeDayVO];
    captureDetailsVO.dateTimeDayVO = dateTimeDayVO;
    
    // saving date, time, day, lat, lng, etc. in core data
    CoreDataUtil *coreDataUtil = [[CoreDataUtil alloc] init];
    BOOL isSaved = [coreDataUtil saveCapturedDetails:captureDetailsVO];
    
    if(isSaved)
        [AlertUtil showAlertWithMessage:@"Saved"];
    else
        [AlertUtil showAlertWithMessage:@"Please try again"];
    
    [self setActivityIndicatorVisibility:NO];
}

-(void)didFailWithError:(NSError *)error {
    AppLog(@"%@", [error localizedDescription]);
}

-(void)locationServiceAlert {
    [AlertUtil showAlertWithMessage:@"Please enable location service to continue"];
}

#pragma mark Activity Indicator

-(void)setActivityIndicatorVisibility:(BOOL)flag {
    self.activityIndicator.hidden = !flag;
}

#pragma mark

@end
