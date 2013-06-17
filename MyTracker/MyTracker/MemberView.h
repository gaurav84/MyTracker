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

@interface MemberView : UIScrollView {
    UIImageView *addMemberImageView;
}

@property (nonatomic, retain) id<MemberViewDelegate> memberViewDelegate;

-(void)displayAddedMemberWithName:(NSString *)name andRelation:(NSString *)relation;

@end
