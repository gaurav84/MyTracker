//
//  CapturedDetailsView.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 16/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapturedDetailsVO.h"

@interface CapturedDetailsView : UIView

@property (nonatomic, retain) CapturedDetailsVO *capturedDetailsVO;

// IBOutlet
@property (nonatomic, retain) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UITextField *placeLabel;

-(void)populateFieldsWithVO:(CapturedDetailsVO *)capturedDetailsVO;

@end
