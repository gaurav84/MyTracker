//
//  CapturedDetailsContoller.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 24/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

// API
#import <QuartzCore/QuartzCore.h>

// Custom
#import "CapturedDetailsContoller.h"
#import "CoreDataUtil.h"
#import "AlertUtil.h"
#import "DateTimeUtil.h"
#import "AddMemberView.h"
#import "ManagePhotosViewController.h"

@interface CapturedDetailsContoller ()

@end

@implementation CapturedDetailsContoller

#pragma mark View lifecycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listOfAllPlaceLabels = [[NSMutableArray alloc] init];
    self.listOfMatchedPlaceLabels = [[NSMutableArray alloc] init];
    
    self.autoSuggestTableView.autoSuggestDelegate = self;
    self.memberView.memberViewDelegate = self;
    
    // initializing core data variables
    self.capturedDetailsVO.listOfMembers = [[NSMutableArray alloc] init];
    self.capturedDetailsVO.listOfPhotos = [[NSMutableArray alloc] init];
    
    // setting top left and top right buttons
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(initCoreDataToSaveDetails:)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    
    // setting title of screen
    [self setTitle:@"Details"];
    
    [self populateFieldsWithVO:self.capturedDetailsVO];
}

-(void)viewWillAppear:(BOOL)animated {
    CoreDataUtil *coreDataUtil = [[CoreDataUtil alloc] init];
    [self.listOfAllPlaceLabels removeAllObjects];
    self.listOfAllPlaceLabels = [coreDataUtil listOfPlaceLabels];
    
    self.numberOfPhotosToBeAdded.text = [NSString stringWithFormat:@"%d Photos", [managePhotosViewController.photosToBeSaved count]];
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

#pragma mark Saving to core data

-(void)initCoreDataToSaveDetails:(id)sender {
    
    [self addPlaceLabel];
    //[self addMemberWithName:self.memberNameField.text withRelation:self.memberRelationField.text];
    
    if([self isValid]) {
        CoreDataUtil *coreDataUtil = [[CoreDataUtil alloc] init];
        BOOL isSaved = [coreDataUtil saveCapturedDetails:self.capturedDetailsVO];
        
        if(isSaved)
            [AlertUtil showAlertWithMessage:@"Saved"];
        else
            [AlertUtil showAlertWithMessage:@"Please try again"];
        
        [self dismissModalViewControllerAnimated:YES];
    }
}

#pragma mark Auto suggest

-(void)populateAutoSuggestListWithString:(NSString *)string {
    [self.listOfMatchedPlaceLabels removeAllObjects];
    for(NSString *arrayItem in self.listOfAllPlaceLabels) {
        if ([arrayItem rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound) {
            if(![self.listOfMatchedPlaceLabels containsObject:arrayItem])
                [self.listOfMatchedPlaceLabels addObject:arrayItem];
        }
    }
}

#pragma mark Misc

// this method adds the 'placeLabel' text to CapturedDetailsVO,
// since this vo encapsulates lat, lng, time, date, label, member, etc. & core data saves CapturedDetailsVO
-(void)addPlaceLabel {
    self.capturedDetailsVO.locationVO.placeLabel = self.placeLabelField.text;
}

#pragma mark Validations

-(BOOL)isValid {
    BOOL flag = true;
    
    if([self.placeLabelField.text isEqualToString:@""]) {
        [AlertUtil showAlertWithMessage:@"Please enter a label for the place"];
        flag = false;
    }
    
    return flag;
}

#pragma mark ------------------ Delegates (Begin) ------------------
#pragma mark MemberView delegate

-(void)addMemberTouched {
    int width = 200;
    int height = 120;
    int x = (self.view.frame.size.width - width)/2;
    int y = self.view.frame.size.height/2 - height;
   
    AddMemberView *addMemberView = [[AddMemberView alloc] initWithFrame:CGRectMake(-width, y, width, height)];
    addMemberView.delegate = self;
    addMemberView.capturedDetailsVO = self.capturedDetailsVO;
    [self.view addSubview:addMemberView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                           forView:addMemberView
                             cache:YES];
    
    addMemberView.frame = CGRectMake(x, y, width, height);
    
    [UIView commitAnimations];
}

#pragma mark AddMemberView delegate 

-(void)updateMemberViewWithName:(NSString *)name andRelation:(NSString *)relation {
    [self.memberView displayAddedMemberWithName:name andRelation:relation];
}

#pragma mark AutoSuggest delegate

-(void)labelTouched:(NSString *)label {
    self.placeLabelField.text = label;
    self.autoSuggestTableView.hidden = YES;
}

#pragma mark Text Field delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self populateAutoSuggestListWithString:substring];
    
    if([self.listOfMatchedPlaceLabels count] > 0) {
        self.autoSuggestTableView.hidden = NO;
        self.autoSuggestTableView.data = self.listOfMatchedPlaceLabels;
        [self.autoSuggestTableView reloadData];
    }
    else {
        self.autoSuggestTableView.hidden = YES;
    }
    
    
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.autoSuggestTableView.hidden = YES;
}

#pragma mark ------------------ Delegates (End) ------------------

#pragma mark IBAction

-(IBAction)addPhotos:(id)sender {
    managePhotosViewController = [[ManagePhotosViewController alloc] init];
    managePhotosViewController.capturedDetailsVO = self.capturedDetailsVO;
    [self.navigationController pushViewController:managePhotosViewController animated:YES];
}

@end
