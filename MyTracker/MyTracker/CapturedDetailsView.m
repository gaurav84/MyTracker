//
//  CapturedDetailsView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 16/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CapturedDetailsView.h"

@implementation CapturedDetailsView

-(id)init {
    if(self = [super init]) {
        [self awakeFromNib];
        return self;
    }
    
    return nil;
}

-(void)awakeFromNib {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"CapturedDetailsView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    [self.placeLabel becomeFirstResponder];
}

-(void)populateFieldsWithVO:(CapturedDetailsVO *)capturedDetailsVO {
    self.latitudeLabel.text = [[NSNumber numberWithFloat:capturedDetailsVO.locationVO.latitude] stringValue];
    self.longitudeLabel.text = [[NSNumber numberWithFloat:capturedDetailsVO.locationVO.longitude] stringValue];
    self.dateLabel.text = [self getDate:capturedDetailsVO.dateTimeDayVO];
    self.timeLabel.text = [self getTime:capturedDetailsVO.dateTimeDayVO];
}

-(NSString *)getDate:(DateTimeDayVO *)dateTimeDayVO {
    return [NSString stringWithFormat:@"%d/%@/%d", dateTimeDayVO.date, dateTimeDayVO.month, dateTimeDayVO.year];
}

-(NSString *)getTime:(DateTimeDayVO *)dateTimeDayVO {
    return [NSString stringWithFormat:@"%d:%d %@", dateTimeDayVO.hour, dateTimeDayVO.min, dateTimeDayVO.meridian];
}

@end
