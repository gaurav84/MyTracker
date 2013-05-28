//
//  MemberView.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 27/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MemberViewDelegate <NSObject>

-(void)addMemberTouched;

@end

@interface MemberView : UIScrollView

@property (nonatomic, retain) id<MemberViewDelegate> memberViewDelegate;

@end
