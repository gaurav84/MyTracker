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
#import "DateTimeUtil.h"
#import "AddMemberView.h"
#import <QuartzCore/QuartzCore.h>

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
    self.listOfAllPlaceLabels = [[NSMutableArray alloc] init];
    self.listOfMatchedPlaceLabels = [[NSMutableArray alloc] init];
    
    self.memberView.memberViewDelegate = self;
    
    // setting top left and top right buttons
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(initCoreDataToSaveDetails:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissModalViewControllerAnimated:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    [self.navigationItem setRightBarButtonItem:saveButton];
    
    // setting title of screen
    [self setTitle:@"Details"];
    
    [self populateFieldsWithVO:self.capturedDetailsVO];
}

-(void)viewWillAppear:(BOOL)animated {
    CoreDataUtil *coreDataUtil = [[CoreDataUtil alloc] init];
    [self.listOfAllPlaceLabels removeAllObjects];
    self.listOfAllPlaceLabels = [coreDataUtil listOfPlaceLabels];
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
    [self.placeLabelField resignFirstResponder];
    return true;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self populateAutoSuggestListWithString:substring];
    
    if([self.listOfMatchedPlaceLabels count] > 0) {
        self.autoSuggestTableView.hidden = NO;
    }
    else
        self.autoSuggestTableView.hidden = YES;
    
    [self.autoSuggestTableView reloadData];
    
    return true;
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
        if ([arrayItem rangeOfString:string].location != NSNotFound) {
            if(![self.listOfMatchedPlaceLabels containsObject:arrayItem])
                [self.listOfMatchedPlaceLabels addObject:arrayItem];
        }
    }
}

#pragma mark AutoSuggest TableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listOfMatchedPlaceLabels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.listOfMatchedPlaceLabels objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.placeLabelField.text = [self.listOfMatchedPlaceLabels objectAtIndex:indexPath.row];
    self.autoSuggestTableView.hidden = YES;
}

#pragma mark Misc

// this method adds the 'placeLabel' text to CapturedDetailsVO,
// since this vo encapsulates lat, lng, time, date, label, member, etc. & core data saves CapturedDetailsVO
-(void)addPlaceLabel {
    self.capturedDetailsVO.locationVO.placeLabel = self.placeLabelField.text;
}

// this method adds the 'member name' and 'member relation' text to CapturedDetailsVO,
// since this vo encapsulates lat, lng, time, date, label, member, etc. & core data saves CapturedDetailsVO
-(void)addMemberWithName:(NSString *)name withRelation:(NSString *)relation {
    self.capturedDetailsVO.memberVO.name = name;
    self.capturedDetailsVO.memberVO.relation = relation;
}

-(BOOL)isValid {
    BOOL flag = true;
    
    if([self.placeLabelField.text isEqualToString:@""]) {
        [AlertUtil showAlertWithMessage:@"Please enter a label for the place"];
        flag = false;
    }
    
    return flag;
}

#pragma mark MemberView delegate

-(void)addMemberTouched {
    int width = 200;
    int height = 120;
    int x = (self.view.frame.size.width - width)/2;
    int y = self.view.frame.size.height/2 - height;
   
    AddMemberView *addMemberView = [[AddMemberView alloc] initWithFrame:CGRectMake(-width, y, width, height)];
    [self.view addSubview:addMemberView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                           forView:addMemberView
                             cache:YES];
    
    addMemberView.frame = CGRectMake(x, y, width, height);
    
    [UIView commitAnimations];
}

@end
