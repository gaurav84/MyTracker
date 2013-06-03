//
//  CoreDataUtil.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 04/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CoreDataUtil.h"
#import <CoreData/CoreData.h>
#import "CapturedDetailsVO.h"
#import "CoreDataFactory.h"
#import "CapturedLocation.h"
#import "Member.h"

@implementation CoreDataUtil

-(BOOL)saveCapturedDetails:(CapturedDetailsVO *)capturedDetailsVO {
    NSError *error;
    
    // Preparing VOs from CapturedDetailsVO
    DateTimeDayVO *dateTimeDayVO = capturedDetailsVO.dateTimeDayVO;
    LocationVO *locationVO = capturedDetailsVO.locationVO;
    
    CoreDataFactory *coreDataFactory = [[CoreDataFactory alloc] init];
    NSManagedObjectContext *context = [coreDataFactory managedObjectContext];
    CapturedLocation *capturedLocation = [NSEntityDescription insertNewObjectForEntityForName:@"CapturedLocation"
                                                                       inManagedObjectContext:context];
    
    
    capturedLocation.latitude = [NSNumber numberWithFloat:locationVO.latitude];
    capturedLocation.longitude = [NSNumber numberWithFloat:locationVO.longitude];
    capturedLocation.placeLabel = locationVO.placeLabel;
    capturedLocation.date = [NSNumber numberWithInt:dateTimeDayVO.date];
    capturedLocation.month = dateTimeDayVO.month;
    capturedLocation.year = [NSNumber numberWithInt:dateTimeDayVO.year];
    capturedLocation.hour = [NSNumber numberWithInt:dateTimeDayVO.hour];
    capturedLocation.min = [NSNumber numberWithInt:dateTimeDayVO.min];
    capturedLocation.sec = [NSNumber numberWithInt:dateTimeDayVO.sec];
    capturedLocation.meridian = dateTimeDayVO.meridian;
    capturedLocation.day = dateTimeDayVO.weekday;
    

    
    for(MemberVO *memberVO in capturedDetailsVO.listOfMembers) {
        Member *member = [NSEntityDescription insertNewObjectForEntityForName:@"Member"
                                                       inManagedObjectContext:context];
        
        member.name = memberVO.name;
        member.relation = memberVO.relation;
        
        [capturedLocation addMemberObject:member];
    }
    
    if (![context save:&error]) {
        AppLog(@"Error saving in core data: %@", [error localizedDescription]);
        return false;
    }
    else {
        AppLog(@"Saved in core data");
        return true;
    }
}

-(CapturedDetailsVO *)getCapturedDetails {
    NSError *error;
    CoreDataFactory *coreDataFactory = [[CoreDataFactory alloc] init];
    NSManagedObjectContext *context = [coreDataFactory managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"CapturedLocation" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *model in fetchedObjects) {        
        NSSet *set = [(CapturedLocation *)model member];
        AppLog(@"%d", [set count]);
        for(Member *member in set) {
            AppLog(@"Member: %@", member);
        }
    }
    
    return nil;
}

-(NSMutableArray *)listOfPlaceLabels {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSError *error;
    CoreDataFactory *coreDataFactory = [[CoreDataFactory alloc] init];
    NSManagedObjectContext *context = [coreDataFactory managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"CapturedLocation" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *model in fetchedObjects) {
        [result addObject:[model valueForKey:@"placeLabel"]];
    }
    
    return result;
}

@end
