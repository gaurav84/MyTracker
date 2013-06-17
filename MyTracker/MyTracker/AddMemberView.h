//
//  AddMemberView.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 28/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapturedDetailsVO.h"

@protocol AddMemberViewDelegate <NSObject>

-(void)updateMemberViewWithName:(NSString *)name andRelation:(NSString *)relation;

@end

@interface AddMemberView : UIView <UITextFieldDelegate>

@property (nonatomic, retain) CapturedDetailsVO *capturedDetailsVO;
@property (nonatomic) id<AddMemberViewDelegate> delegate;

// IBOutlet
@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *relationField;

@end
