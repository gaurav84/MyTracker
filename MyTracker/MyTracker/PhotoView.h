//
//  PhotoView.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 06/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIImageView {
    UIImageView *checkmarkView;
}

@property (nonatomic, retain) NSData *imageData;
@property (nonatomic) BOOL isSelected;

-(void)showImageWithData:(NSData *)data;

@end
