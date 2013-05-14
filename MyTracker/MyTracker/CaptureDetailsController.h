//
//  ViewController.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 30/04/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocationManager.h"

@interface CaptureDetailsController : UIViewController <CoreLocationManagerDelegate>

@property (nonatomic, retain) CoreLocationManager *coreLocationManager;

@end
