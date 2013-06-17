//
//  CapturedLocation.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 05/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Member;

@interface CapturedLocation : NSManagedObject

@property (nonatomic, retain) NSNumber * date;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSNumber * hour;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * meridian;
@property (nonatomic, retain) NSNumber * min;
@property (nonatomic, retain) NSString * month;
@property (nonatomic, retain) NSString * placeLabel;
@property (nonatomic, retain) NSNumber * sec;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *member;
@property (nonatomic, retain) NSSet *image;
@end

@interface CapturedLocation (CoreDataGeneratedAccessors)

- (void)addMemberObject:(Member *)value;
- (void)removeMemberObject:(Member *)value;
- (void)addMember:(NSSet *)values;
- (void)removeMember:(NSSet *)values;
- (void)addImageObject:(Image *)value;
- (void)removeImageObject:(Image *)value;
- (void)addImage:(NSSet *)values;
- (void)removeImage:(NSSet *)values;
@end
