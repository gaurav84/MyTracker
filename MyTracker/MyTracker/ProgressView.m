//
//  ProgressView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 13/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

-(void)awakeFromNib {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"ProgressView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
}

-(void)updateLabelWithProgress:(NSString *)progress {
    NSLog(@"PROGRESS: %@", progress);

    self.progressLabel.text = progress;
    
}


@end
