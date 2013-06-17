//
//  InternetUtil.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 16/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "InternetUtil.h"
#import "Reachability.h"

@implementation InternetUtil

+(BOOL)isInternetAvailable {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) 
        return false;
     else
         return true;
}



@end
