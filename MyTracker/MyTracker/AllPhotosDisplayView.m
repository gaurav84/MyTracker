//
//  AllPhotosDisplayView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 06/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "AllPhotosDisplayView.h"
#import "PhotoView.h"
#import "ImageVO.h"

@implementation AllPhotosDisplayView

int currentPhotoIndex = 0;
int photoWidth = 150;
int photoHeight = 150;
int holdY = 0;

#pragma mark View lifecycle method

-(void)awakeFromNib {
    currentPhotoIndex = 0;
}

#pragma mark

-(void)showImageWithData:(NSData *)imageData {
    currentPhotoIndex++;
    CGRect availableSlot = [self getNextAvailableSlotForIndex:currentPhotoIndex];
    
    PhotoView *photoView = [[PhotoView alloc] initWithFrame:availableSlot];
    [photoView showImageWithData:imageData];
    [self addSubview:photoView];
}

#pragma mark

-(CGRect)getNextAvailableSlotForIndex:(int)index {

//    int x = 0, y = 0;
//    if (index % 2) {
//        x = 0;
//        y = photoHeight * (index - 1);
//        holdY = y;
//    }
//    else {
//        x = photoWidth;
//        y = holdY;
//    }
//
//    return CGRectMake(x, y, photoWidth, photoHeight);
}

#pragma mark

@end
