//
//  CapturedDetailsView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 16/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CapturedDetailsView.h"

@implementation CapturedDetailsView

-(id)init {
    if(self = [super init]) {
        [self prepareGrid];
        return self;
    }
    
    return nil;
}

-(void)prepareGrid {
    int columns = 2;
    int rows = 7;
    int rowHeight = 20;

    for (int i=0; i<rows; i++) {
        for (int j=0; j<columns; j++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50 * i, 50 * j, 100, rowHeight)];
            label.text = [NSString stringWithFormat:@"X %d-%d", i , j];
            [self addSubview:label];
        }
    }
}

-(void)drawRect:(CGRect)rect {
    
}

@end
