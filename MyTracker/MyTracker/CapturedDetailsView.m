//
//  CapturedDetailsView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 16/05/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "CapturedDetailsView.h"

@implementation CapturedDetailsView

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self prepareGrid];
        return self;
    }
    
    return nil;
}

-(void)prepareGrid {
    int columns = 2;
    int rows = 7;
    int rowHeight = 20;

    for (int i=0; i<columns; i++) {
        for (int j=0; j<rows; j++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50 * i, rowHeight * j, 75, rowHeight)];
            label.text = [NSString stringWithFormat:@"%d%d", j , i];
            [self addSubview:label];
        }
    }
}

-(void)drawRect:(CGRect)rect {
    
}

@end
