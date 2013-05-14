//
//  CoreDataUtil.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 04/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CoreDataUtil.h"
#import <CoreData/CoreData.h>
#import "CaptureDetailsVO.h"
#import "CoreDataFactory.h"

@implementation CoreDataUtil

-(BOOL)saveCapturedDetails:(CaptureDetailsVO *)captureDetailsVO {
    NSError *error;
    CoreDataFactory *coreDataFactory = [[CoreDataFactory alloc] init];
    NSManagedObjectContext *context = [coreDataFactory managedObjectContext];
    NSManagedObject *model = [NSEntityDescription
                              insertNewObjectForEntityForName:@"CapturedLocation"
                              inManagedObjectContext:context];
    
    // CaptureDetailsVO contains DateTimeDayVO & LocationVO
    DateTimeDayVO *dateTimeDayVO = captureDetailsVO.dateTimeDayVO;
    LocationVO *locationVO = captureDetailsVO.locationVO;
    
    [model setValue:[NSNumber numberWithInt:dateTimeDayVO.date] forKey:@"date"];
    [model setValue:dateTimeDayVO.weekday forKey:@"day"];
    [model setValue:[NSNumber numberWithInt:dateTimeDayVO.hour] forKey:@"hour"];
    [model setValue:[NSNumber numberWithInt:locationVO.latitude] forKey:@"latitude"];
    [model setValue:[NSNumber numberWithInt:locationVO.longitude] forKey:@"longitude"];
    [model setValue:dateTimeDayVO.meridian forKey:@"meridian"];
    [model setValue:[NSNumber numberWithInt:dateTimeDayVO.min] forKey:@"min"];
    [model setValue:dateTimeDayVO.month forKey:@"month"];
    [model setValue:[NSNumber numberWithInt:dateTimeDayVO.sec] forKey:@"sec"];
    [model setValue:[NSNumber numberWithInt:dateTimeDayVO.year] forKey:@"year"];
    
    if (![context save:&error]) {
        AppLog(@"Error saving in core data: %@", [error localizedDescription]);
        return false;
    }
    else {
        AppLog(@"Saved in core data");
        return true;
    }
}

//-(CaptureDetailsVO *)getCapturedDetails {
//    NSError *error;
//    CoreDataFactory *coreDataFactory = [[CoreDataFactory alloc] init];
//    NSManagedObjectContext *context = [coreDataFactory managedObjectContext];
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"CapturedLocation" inManagedObjectContext:context];
//    
//    [fetchRequest setEntity:entity];
//    
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    
//    for (NSManagedObject *model in fetchedObjects) {
//        AppLog(@"Value: %@", [model valueForKey:@"year"]);
//        AppLog(@"Value: %@", [model valueForKey:@"month"]);
//    }
//    
//    return nil;
//}

@end