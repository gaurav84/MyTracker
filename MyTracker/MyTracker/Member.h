//
//  Member.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 03/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CapturedLocation;

@interface Member : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * relation;
@property (nonatomic, retain) CapturedLocation *capturedLocation;

@end
