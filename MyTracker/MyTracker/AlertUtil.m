//
//  AppAlert.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 15/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "AlertUtil.h"

@implementation AlertUtil

+(void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"My Tracker" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

@end
