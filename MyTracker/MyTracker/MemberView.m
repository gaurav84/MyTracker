//
//  MemberView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 27/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "MemberView.h"

@implementation MemberView

-(void)awakeFromNib {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 75, 50)];
    imageView.image = [UIImage imageNamed:@"plus.png"];
    [self addSubview:imageView];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
    [imageView addGestureRecognizer:gestureRecognizer];
    [imageView setUserInteractionEnabled:YES];
}

-(void)handleTouch:(UITapGestureRecognizer *)gesture {
    [self.memberViewDelegate addMemberTouched];
}

#pragma mark

@end