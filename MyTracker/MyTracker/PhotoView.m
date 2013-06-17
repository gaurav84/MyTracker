//
//  PhotoView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 06/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "PhotoView.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#pragma mark Showing image with NSData

-(void)showImageWithData:(NSData *)data {
    self.image = [UIImage imageWithData:data];
    self.contentMode = UIViewContentModeScaleAspectFit;
}


@end
