//
//  CapturedDetailsVO.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 03/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CapturedDetailsVO.h"

@implementation CapturedDetailsVO

+(CapturedDetailsVO *)getInstance {
    static CapturedDetailsVO *instance = nil;
    static dispatch_once_t obj;
    dispatch_once(&obj, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
