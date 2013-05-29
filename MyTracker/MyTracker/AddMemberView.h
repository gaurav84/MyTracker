//
//  AddMemberView.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 28/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapturedDetailsVO.h"

@interface AddMemberView : UIView <UITextFieldDelegate>

@property (nonatomic, retain) CapturedDetailsVO *capturedDetailsVO;

// IBOutlet
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *relationField;

@end
