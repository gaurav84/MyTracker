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
int photoWidth = 145;
int photoHeight = 145;
int kHorizontalPadding = 10;
int kVerticalPadding = 5;
int count = -1;
int scrollCount = 0;

#pragma mark View lifecycle method

-(void)awakeFromNib {
    currentPhotoIndex = 0;
    count = -1;
    scrollCount = 0;
}

#pragma mark Showing image

-(void)showImage:(id)arg {
    currentPhotoIndex++;
    CGRect availableSlot = [self getNextAvailableSlotForIndex:currentPhotoIndex];
    
    PhotoView *photoView = [[PhotoView alloc] initWithFrame:availableSlot];
    [self addSubview:photoView];
    
    if([arg isKindOfClass:[NSData class]])
        [photoView showImageWithData:arg];
    else
        [photoView showImageWithUrl:arg];
    
    [self manageContentSizeForIndex:currentPhotoIndex];
}



#pragma mark Get Slot

-(CGRect)getNextAvailableSlotForIndex:(int)index {

    int x = 0, y = 0;
    if (index % 2) {
        x = kHorizontalPadding;
        count ++;
    }
    else
        x = photoWidth + kHorizontalPadding * 2;

    y = (kVerticalPadding * (count + 1)) + (count * photoHeight);
    
    return CGRectMake(x, y, photoWidth, photoHeight);
}

#pragma mark Content Size

-(void)manageContentSizeForIndex:(int)index {
    if(index % 2) {
        scrollCount ++;
        [self setContentSize:CGSizeMake(0, scrollCount * photoHeight + 20)];
    }
}

-(void)showCheckmarkOnSelectedImage:(UIImage *)image {
}


@end
