//
//  CapturedDetailsContoller.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 24/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapturedDetailsVO.h"

@interface CapturedDetailsContoller : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) CapturedDetailsVO *capturedDetailsVO;

// IBOutlet
@property (nonatomic, retain) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UITextField *labelField;
@property (nonatomic, retain) IBOutlet UITextField *memberNameField;
@property (nonatomic, retain) IBOutlet UITextField *memberRelationField;

@end
