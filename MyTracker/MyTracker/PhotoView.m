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
        checkmarkView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        checkmarkView.image = [UIImage imageNamed:@"checkmark.png"];
        [self addSubview:checkmarkView];
        
        self.isSelected = YES;
        
        UITapGestureRecognizer *imageGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouched:)];
        [self addGestureRecognizer:imageGestureRecognizer];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

#pragma mark Showing image with NSData

-(void)showImageWithData:(NSData *)data {
    self.image = [UIImage imageWithData:data];
    self.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark UITapGestureRecognizer

-(void)imageTouched:(UITapGestureRecognizer *)gestureRecognizer {
    if(self.isSelected) {
        self.isSelected = NO;
        checkmarkView.hidden = YES;
    }
    else {
        self.isSelected = YES;
        checkmarkView.hidden = NO;
    }
}


@end
