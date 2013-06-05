//
//  Image.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 05/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CapturedLocation;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSData * path;
@property (nonatomic, retain) CapturedLocation *capturedLocation;

@end
