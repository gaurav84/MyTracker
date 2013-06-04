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
#define kHorizontalScrollPadding 10

@implementation MemberView

// the variable 'memberIndex' is incremented everytime a new member is added, this serves two purpose - 1) Tells the total number of added members in this class and 2) helps in setting CGRect/frame for adding new members
int memberIndex = 0;

#pragma mark View lifecycle

-(void)awakeFromNib {
    
    // addMemberImageView is an image view, touching which allows user to add members to the captured location
    addMemberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftPadding, kTopPadding, kAddMemberImageViewWidth, kAddMemberImageViewHeight)];
    addMemberImageView.image = [UIImage imageNamed:@"plus.png"];
    [self addSubview:addMemberImageView];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
    [addMemberImageView addGestureRecognizer:gestureRecognizer];
    [addMemberImageView setUserInteractionEnabled:YES];
}

#pragma mark Single Tap Gesture

-(void)handleTouch:(UITapGestureRecognizer *)gesture {
    NSLog(@"Single tap");
    [self.memberViewDelegate addMemberTouched];
}

#pragma mark Displaying Added members

-(void)displayAddedMemberWithName:(NSString *)name andRelation:(NSString *)relation  {
   
    // adding a new UIView for an added member
    CGRect addedMemberFrame = CGRectMake((kLeftPadding * (memberIndex + 1)) + (memberIndex * kAddMemberImageViewWidth),
                                                  kTopPadding,
                                                  kAddMemberImageViewWidth,
                                                  kAddMemberImageViewHeight);
    UIView *addedMember = [[UIView alloc] initWithFrame:addedMemberFrame];
    addedMember.backgroundColor = [UIColor blueColor];
    [self addSubview:addedMember];
    
    // setting frame for added member, and adding it
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kAddMemberImageViewWidth, kAddMemberImageViewHeight)];
    nameLabel.text = name;
    nameLabel.textAlignment = UITextAlignmentCenter;
    [addedMember addSubview:nameLabel];
    
    memberIndex ++;

    [self manageContentSize];
    [self rePositionAddMemberImageView];
}

#pragma mark Content Size for ScrollView

-(void)manageContentSize {
    [self setContentSize:CGSizeMake((memberIndex * (kLeftPadding + kAddMemberImageViewWidth)) + kAddMemberImageViewWidth + kHorizontalScrollPadding, 0)];
}

#pragma mark Re-position of AddMember Image View

-(void)rePositionAddMemberImageView {
    // shifting AddMemberImageView placeholder to its next position
    CGRect frameForAddMemberPlaceholder = CGRectMake((kLeftPadding * (memberIndex + 1)) + (memberIndex * kAddMemberImageViewWidth),
                                                     kTopPadding,
                                                     kAddMemberImageViewWidth,
                                                     kAddMemberImageViewHeight);
    
    [addMemberImageView setFrame:frameForAddMemberPlaceholder];
}

@end