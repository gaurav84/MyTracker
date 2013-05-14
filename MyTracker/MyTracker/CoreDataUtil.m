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

-(void)saveCapturedDetails:(CaptureDetailsVO *)captureDetailsVO {
    NSError *error;
    CoreDataFactory *coreDataFactory = [[CoreDataFactory alloc] init];
    NSManagedObjectContext *context = [coreDataFactory managedObjectContext];
    NSManagedObject *model = [NSEntityDescription
                              insertNewObjectForEntityForName:@"CapturedLocation"
                              inManagedObjectContext:context];
    
    [model setValue:[NSNumber numberWithInt:[@"2012" intValue]] forKey:@"year"];
    [model setValue:@"March" forKey:@"month"];
    
    
    if (![context save:&error]) {
        AppLog(@"Couldn't save: %@", [error localizedDescription]);
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
