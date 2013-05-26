//
//  CapturedDetailsVO.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 03/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationVO.h"
#import "DateTimeDayVO.h"
#import "MemberVO.h"

@interface CapturedDetailsVO : NSObject

@property (nonatomic, retain) LocationVO *locationVO;
@property (nonatomic, retain) DateTimeDayVO *dateTimeDayVO;
@property (nonatomic, retain) MemberVO *memberVO;

+(CapturedDetailsVO *)getInstance;

@end
