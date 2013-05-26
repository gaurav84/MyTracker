//
//  CapturedDetailsContoller.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 24/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CapturedDetailsContoller.h"
#import "CoreDataUtil.h"
#import "AlertUtil.h"

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

#pragma mark Populating Latitude, Longitude, Date and Time

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

#pragma mark Text Field delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.labelField resignFirstResponder];
    [self.memberNameField resignFirstResponder];
    [self.memberRelationField resignFirstResponder];
    return true;
}

#pragma mark Saving to core data

-(void)initCoreDataToSaveDetails:(id)sender {

    [self addLabel];
    [self addMemberWithName:self.memberNameField.text withRelation:self.memberRelationField.text];
    
    if(self.labelField.text != @"") {
        
        CoreDataUtil *coreDataUtil = [[CoreDataUtil alloc] init];
        BOOL isSaved = [coreDataUtil saveCapturedDetails:self.capturedDetailsVO];
        
        if(isSaved)
            [AlertUtil showAlertWithMessage:@"Saved"];
        else
            [AlertUtil showAlertWithMessage:@"Please try again"];
    }
}

#pragma mark Misc

-(void)addLabel {
    self.capturedDetailsVO.locationVO.label = self.labelField.text;
}

-(void)addMemberWithName:(NSString *)name withRelation:(NSString *)relation {
    self.capturedDetailsVO.memberVO.name = name;
    self.capturedDetailsVO.memberVO.relation = relation;
}

#pragma mark

@end
