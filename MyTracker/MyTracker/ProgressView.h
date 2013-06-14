//
//  ProgressView.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 13/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

// IBOutlet
@property (nonatomic, retain) IBOutlet UILabel *progressLabel;

-(void)updateLabelWithProgress:(NSString *)progress;

@end
