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
#define kAddMemberImageViewWidth 125
#define kAddMemberImageViewHeight 50

@implementation MemberView

-(void)awakeFromNib {
    addMemberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftPadding, kTopPadding, kAddMemberImageViewWidth, kAddMemberImageViewHeight)];
    addMemberImageView.image = [UIImage imageNamed:@"plus.png"];
    [self addSubview:addMemberImageView];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
    [addMemberImageView addGestureRecognizer:gestureRecognizer];
    [addMemberImageView setUserInteractionEnabled:YES];
}

-(void)handleTouch:(UITapGestureRecognizer *)gesture {
    [self.memberViewDelegate addMemberTouched];
}

#pragma mark Displaying Added members

-(void)displayAddedMemberWithName:(NSString *)name andRelation:(NSString *)relation  {
    
    CGRect newFrame = CGRectMake(4 + 125 + 4, 4, 125, 50);
    [addMemberImageView setFrame:newFrame];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 4, 125, 50)];
    nameLabel.text = name;
    [self addSubview:nameLabel];
}

@end