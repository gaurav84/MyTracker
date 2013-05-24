//
//  CapturedDetailsContoller.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 24/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CapturedDetailsContoller.h"

@interface CapturedDetailsContoller ()

@end

@implementation CapturedDetailsContoller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(initCoreDataToSaveDetails:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissModalViewControllerAnimated:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    [self.navigationItem setRightBarButtonItem:saveButton];
    [self setTitle:@"Details"];
    
    [self populateFieldsWithVO:self.capturedDetailsVO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    AppLog(@"Received memory warning!");
}

-(void)initCoreDataToSaveDetails {
    
}

-(void)populateFieldsWithVO:(CapturedDetailsVO *)capturedDetailsVO {
    self.latitudeLabel.text = [[NSNumber numberWithFloat:capturedDetailsVO.locationVO.latitude] stringValue];
    self.longitudeLabel.text = [[NSNumber numberWithFloat:capturedDetailsVO.locationVO.longitude] stringValue];
    self.dateLabel.text = [self getDate:capturedDetailsVO.dateTimeDayVO];
    self.timeLabel.text = [self getTime:capturedDetailsVO.dateTimeDayVO];
}

-(NSString *)getDate:(DateTimeDayVO *)dateTimeDayVO {
    return [NSString stringWithFormat:@"%d/%@/%d", dateTimeDayVO.date, dateTimeDayVO.month, dateTimeDayVO.year];
}

-(NSString *)getTime:(DateTimeDayVO *)dateTimeDayVO {
    return [NSString stringWithFormat:@"%d:%d %@", dateTimeDayVO.hour, dateTimeDayVO.min, dateTimeDayVO.meridian];
}

#pragma mark

@end
