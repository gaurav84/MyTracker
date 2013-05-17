//
//  InternetUtil.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 16/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;

@interface InternetUtil : NSObject

+(BOOL)isInternetAvailable;

@end
