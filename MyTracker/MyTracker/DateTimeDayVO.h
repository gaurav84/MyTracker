//
//  DateTimeDayVO.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 30/04/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTimeDayVO : NSObject

@property (nonatomic) int date;
@property (nonatomic, retain) NSString *month;
@property (nonatomic) int year;
@property (nonatomic, retain) NSString *weekday;
@property (nonatomic) int hour;
@property (nonatomic) int min;
@property (nonatomic) int sec;
@property (nonatomic) NSString *meridian;

@end
