//
//  AppDelegate.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 30/04/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CaptureDetailsController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CaptureDetailsController *viewController;
@property (strong, nonatomic) UINavigationController *navController;


@end
