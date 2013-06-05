//
//  ActionSheetUtil.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 04/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActionSheetDelegate <NSObject>

-(void)showCamera;
-(void)showGallery;

@end

@interface ActionSheetUtil : UIActionSheet <UIActionSheetDelegate>

@property (nonatomic, retain) id<ActionSheetDelegate> actionSheetDelegate;
@property (nonatomic, retain) UIActionSheet *actionSheet;

-(void)actionSheetForAddingPhotosInView:(UIView *)view;

@end
