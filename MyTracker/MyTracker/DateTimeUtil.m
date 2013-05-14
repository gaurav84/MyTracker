//
//  DateTimeUtility.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 30/04/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "DateTimeUtil.h"
#import "DateTimeDayVO.h"

@implementation DateTimeUtil

NSDateFormatter *dateFormatter;

+(DateTimeDayVO *)getDateTimeDayVO {
    DateTimeDayVO *dateTimeDayVO = [[DateTimeDayVO alloc] init];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    NSString *detailedDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(.*)-(.*)-(.*) (.*):(.*):(.*) (.*)"
                                                                           options:0
                                                                             error:NULL];
    NSTextCheckingResult *results = [regex firstMatchInString:detailedDateString
                                                      options:0
                                                        range:NSMakeRange(0, [detailedDateString length])];
    
    dateTimeDayVO.year = [[detailedDateString substringWithRange:[results rangeAtIndex:1]] intValue];
    dateTimeDayVO.month = [detailedDateString substringWithRange:[results rangeAtIndex:2]];
    dateTimeDayVO.date = [[detailedDateString substringWithRange:[results rangeAtIndex:3]] intValue];
    dateTimeDayVO.hour = [[detailedDateString substringWithRange:[results rangeAtIndex:4]] intValue];
    dateTimeDayVO.min = [[detailedDateString substringWithRange:[results rangeAtIndex:5]] intValue];
    dateTimeDayVO.sec = [[detailedDateString substringWithRange:[results rangeAtIndex:6]] intValue];
    dateTimeDayVO.meridian = [detailedDateString substringWithRange:[results rangeAtIndex:7]];
    dateTimeDayVO.weekday = [self getWeekdayFromDate:detailedDateString];
    
    
    return dateTimeDayVO;
}

+(NSString *)getWeekdayFromDate:(NSString *)dateString {
    CFAbsoluteTime absoluteTime = CFAbsoluteTimeGetCurrent();
    CFTimeZoneRef timeZone = CFTimeZoneCopySystem();
    SInt32 weekdayNumber = CFAbsoluteTimeGetDayOfWeek(absoluteTime, timeZone);
    
    // Per ISO-8601, Monday is represented by 1, Tuesday by 2, etc.
    switch (weekdayNumber) {
        case 1:
            return @"Monday";
            break;
        case 2:
            return @"Tuesday";
            break;
        case 3:
            return @"Wednesday";
            break;
        case 4:
            return @"Thursday";
            break;
        case 5:
            return @"Friday";
            break;
        case 6:
            return @"Saturday";
            break;
        case 7:
            return @"Sunday";
            break;
        default:
            return @"nil";
            break;
    }
    
    return @"";
}

@end
