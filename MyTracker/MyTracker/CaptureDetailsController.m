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
#import "CapturedDetailsVO.h"
#import "AlertUtil.h"
#import "CapturedDetailsContoller.h"
#import "InternetUtil.h"
#import "CoreDataUtil.h"

@interface CaptureDetailsController ()

@end

@implementation CaptureDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSettings];
    self.coreLocationManager = [CoreLocationManager getInstance];
    self.coreLocationManager.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated {
    [self.view setFrame:CGRectMake(0, 0, 320, 568)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    AppLog(@"Received memory warning!");
}

#pragma mark CoreLocationManager delegate methods

-(void)didReceiveLocation:(LocationVO *)locationVO {
    
    // preparing the CapturedDetailsVO which will store the lat, lng, date, time, day, etc..
    CapturedDetailsVO *capturedDetailsVO = [CapturedDetailsVO getInstance];
    capturedDetailsVO.locationVO = locationVO;
    
    // getting the DateTimeDayVO
    DateTimeDayVO *dateTimeDayVO = [DateTimeUtil getDateTimeDayVO];
    capturedDetailsVO.dateTimeDayVO = dateTimeDayVO;
    
    [self displayCapturedDetailsController:capturedDetailsVO];
    
    [self setActivityIndicatorVisible:NO];
}

-(void)didFailWithError:(NSError *)error {
    AppLog(@"%@", [error localizedDescription]);
}

-(void)locationServiceAlert {
    [self setActivityIndicatorVisible:NO];
    [AlertUtil showAlertWithMessage:@"Please enable location service to continue"];
}

#pragma mark Activity Indicator

-(void)setActivityIndicatorVisible:(BOOL)flag {
    self.activityIndicator.hidden = !flag;
}

#pragma mark General Settings

-(void)initialSettings {
    [self setActivityIndicatorVisible:NO];
    self.title = @"My Tracker";
}

#pragma mark Captured Details Controller

-(void)displayCapturedDetailsController:(CapturedDetailsVO *)capturedDetailsVO {
    CapturedDetailsContoller *capturedDetailsContoller = [[CapturedDetailsContoller alloc] init];
    capturedDetailsContoller.capturedDetailsVO = capturedDetailsVO;
    
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:capturedDetailsContoller];
//    [self presentModalViewController:navigationController animated:YES];
    
       
    [self.navigationController pushViewController:capturedDetailsContoller animated:YES];
}

#pragma mark IBAction

-(IBAction)captureDetails:(id)sender {
    if([InternetUtil isInternetAvailable]) {
        [self setActivityIndicatorVisible:YES];
        [self.coreLocationManager startLocationService];
    }
    else {
        [AlertUtil showAlertWithMessage:@"Please connect to internet."];
    }
    
//    CoreDataUtil *core = [[CoreDataUtil alloc] init];
//    [core getCapturedDetails];
}

#pragma mark

@end
