//
//  AllPhotosDisplayView.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 06/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllPhotosDisplayView : UIScrollView

@property (nonatomic, retain) NSMutableArray *source;

-(void)showImageWithData:(NSData *)imageData;

@end
