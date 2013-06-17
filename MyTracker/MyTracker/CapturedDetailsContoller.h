//
//  CapturedDetailsContoller.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 24/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapturedDetailsVO.h"
#import "MemberView.h"
#import "AddMemberView.h"
#import "AutoSuggest.h"
#import "ManagePhotosViewController.h"

@interface CapturedDetailsContoller : UIViewController <UITextFieldDelegate,
                                                        UINavigationControllerDelegate,
                                                        UIImagePickerControllerDelegate,
                                                        AutoSuggestDelegate,
                                                        MemberViewDelegate,
                                                        AddMemberViewDelegate>
{
    ManagePhotosViewController *managePhotosViewController;
}

@property (nonatomic, retain) CapturedDetailsVO *capturedDetailsVO;
@property (nonatomic, retain) NSMutableArray *listOfAllPlaceLabels;
@property (nonatomic, retain) NSMutableArray *listOfMatchedPlaceLabels;

// IBOutlet
@property (nonatomic, retain) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UITextField *placeLabelField;
@property (nonatomic, retain) IBOutlet MemberView *memberView;
@property (nonatomic, retain) IBOutlet AutoSuggest *autoSuggestTableView;
@property (nonatomic, retain) IBOutlet UILabel *numberOfPhotosToBeAdded;

@end
