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
#import "CoreDataUtil.h"
#import "AlertUtil.h"
#import "CapturedDetailsView.h"
#import "InternetUtil.h"

@interface CaptureDetailsController ()

@end

@implementation CaptureDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialSettings];
    self.coreLocationManager = [CoreLocationManager getInstance];
    self.coreLocationManager.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    AppLog(@"Received memory warning!");
}

-(IBAction)captureDetails:(id)sender {
    if([InternetUtil isInternetAvailable]) {
        [self setActivityIndicatorVisible:YES];
        [self.coreLocationManager startLocationService];
    }
    else {
        [AlertUtil showAlertWithMessage:@"Please connect to internet."];
    }
}

#pragma mark CoreLocationManager delegate methods

-(void)didReceiveLocation:(LocationVO *)locationVO {
    self.capturedDetailsView.hidden = NO;

    // preparing the CapturedDetailsVO which will store the lat, lng, date, time, day, etc..
    CapturedDetailsVO *capturedDetailsVO = [CapturedDetailsVO getInstance];
    capturedDetailsVO.locationVO = locationVO;
    
    // getting the DateTimeDayVO
    DateTimeDayVO *dateTimeDayVO = [DateTimeUtil getDateTimeDayVO];
    capturedDetailsVO.dateTimeDayVO = dateTimeDayVO;
    
    [self displayCapturedDetailsView:capturedDetailsVO];
    
    // saving date, time, day, lat, lng, etc. in core data
//    CoreDataUtil *coreDataUtil = [[CoreDataUtil alloc] init];
//    BOOL isSaved = [coreDataUtil saveCapturedDetails:capturedDetailsVO];
//    
//    if(isSaved)
//        [AlertUtil showAlertWithMessage:@"Saved"];
//    else
//        [AlertUtil showAlertWithMessage:@"Please try again"];
    
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
    self.capturedDetailsView.hidden = YES;
}

#pragma mark Captured Details View

-(void)displayCapturedDetailsView:(CapturedDetailsVO *)capturedDetailsVO {
    [self removeExistingView];
    CapturedDetailsView *capturedDetailsView = [[CapturedDetailsView alloc] init];
    [capturedDetailsView populateFieldsWithVO:capturedDetailsVO];
    [self setFrameForView:capturedDetailsView];
    [self.view addSubview:capturedDetailsView];
}

-(void)removeExistingView {
    for(UIView *view in [self.view subviews]) {
        if([view isKindOfClass:[CapturedDetailsView class]]) {
            [view removeFromSuperview];
        }
    }
}

-(void)setFrameForView:(UIView *)view {
    CGRect frame = view.frame;
    frame.origin = CGPointMake(30, 120);
    [view setFrame:frame];
}

#pragma mark 

#pragma mark

@end
