//
//  CoreDataUtil.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 04/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CapturedDetailsVO.h"

@interface CoreDataUtil : NSObject

// methods for saving data
-(BOOL)saveCapturedDetails:(CapturedDetailsVO *)capturedDetailsVO;

// methods for fetching data
-(CapturedDetailsVO *)getCapturedDetails;
-(NSMutableArray *)listOfPlaceLabels;

@end
