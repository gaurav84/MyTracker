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

@interface CaptureDetailsController ()

@end

@implementation CaptureDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coreLocationManager = [CoreLocationManager getInstance];
    self.coreLocationManager.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    AppLog(@"Received memory warning!");
}

-(IBAction)captureDetails:(id)sender {
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
        self.status.text = @"Saved in DB";
    else
        self.status.text = @"Error saving, please try again";
    
    [coreDataUtil getCapturedDetails];
}

-(void)didFailWithError:(NSError *)error {
    AppLog(@"%@", [error localizedDescription]);
}

-(void)locationServiceAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enable location service to continue" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark

@end
