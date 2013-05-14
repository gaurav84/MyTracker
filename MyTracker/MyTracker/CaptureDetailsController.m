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
    
    DateTimeDayVO *dateTimeDayVO = [DateTimeUtil getDateTimeDayVO];
    
    CaptureDetailsVO *captureDetailsVO = [CaptureDetailsVO getInstance];
    captureDetailsVO.dateTimeDayVO = dateTimeDayVO;
    
    CoreDataUtil *coreDataUtil = [[CoreDataUtil alloc] init];
    [coreDataUtil saveCapturedDetails:captureDetailsVO];
}

#pragma mark CoreLocationManager delegate methods

-(void)didReceiveLocation:(LocationVO *)locationVO {
    CaptureDetailsVO *captureDetailsVO = [CaptureDetailsVO getInstance];
    captureDetailsVO.locationVO = locationVO;
}

-(void)didFailWithError:(NSError *)error {
    AppLog(@"%@", [error localizedDescription]);
}

#pragma mark

@end
