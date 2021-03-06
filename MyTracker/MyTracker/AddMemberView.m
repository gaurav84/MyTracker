//
//  AddMemberView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 28/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "AddMemberView.h"

@implementation AddMemberView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"AddMemberView" owner:self options:nil] objectAtIndex:0];
        [self addSubview:view];
    }
    return self;
}

#pragma mark IBAction

-(IBAction)cancelTouched:(id)sender {
    [self removeFromSuperview];
    //AppLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
}

-(IBAction)addTouched:(id)sender {
    if(![self.nameField.text isEqualToString:@""] && ![self.relationField.text isEqualToString:@""]) {
        MemberVO *memberVO = [[MemberVO alloc] init];
        memberVO.name = self.nameField.text;
        memberVO.relation = self.relationField.text;
    
        [self.capturedDetailsVO.listOfMembers addObject:memberVO];
    
        [self removeFromSuperview];
        [[self delegate] updateMemberViewWithName:self.nameField.text andRelation:self.relationField.text];
    }
}

#pragma mark UITextField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

@end
