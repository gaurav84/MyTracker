//
//  MemberView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 27/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "MemberView.h"

#define kLeftPadding 4
#define kTopPadding 4
#define kAddMemberImageViewWidth 100
#define kAddMemberImageViewHeight 50

@implementation MemberView

int memberIndex = 0;

#pragma mark View lifecycle

-(void)awakeFromNib {
    addMemberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftPadding, kTopPadding, kAddMemberImageViewWidth, kAddMemberImageViewHeight)];
    addMemberImageView.image = [UIImage imageNamed:@"plus.png"];
    [self addSubview:addMemberImageView];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
    [addMemberImageView addGestureRecognizer:gestureRecognizer];
    [addMemberImageView setUserInteractionEnabled:YES];
}

#pragma mark Single Tap Gesture

-(void)handleTouch:(UITapGestureRecognizer *)gesture {
    [self.memberViewDelegate addMemberTouched];
}

#pragma mark Long Press Gesture

-(void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    NSLog(@"----------------------");
}

#pragma mark Displaying Added members

-(void)displayAddedMemberWithName:(NSString *)name andRelation:(NSString *)relation  {
    // setting frame for newly added member, and adding it
    CGRect nameLabelFrame = CGRectMake((kLeftPadding * (memberIndex + 1)) + (memberIndex * kAddMemberImageViewWidth),
                                       kTopPadding,
                                       kAddMemberImageViewWidth,
                                       kAddMemberImageViewHeight);
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelFrame];
    nameLabel.text = name;
    nameLabel.textAlignment = UITextAlignmentCenter;
    [self addSubview:nameLabel];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [nameLabel addGestureRecognizer:longPressGesture];
    [nameLabel setUserInteractionEnabled:YES];
    
    memberIndex ++;

    // shifting AddMemberImageView placeholder to its next position
    CGRect newFrameForAddMember = CGRectMake((kLeftPadding * (memberIndex + 1)) + (memberIndex * kAddMemberImageViewWidth),
                                 kTopPadding,
                                 kAddMemberImageViewWidth,
                                 kAddMemberImageViewHeight);
    
    [addMemberImageView setFrame:newFrameForAddMember];    
}

@end