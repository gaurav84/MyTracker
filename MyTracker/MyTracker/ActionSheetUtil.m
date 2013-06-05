//
//  ActionSheetUtil.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 04/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "ActionSheetUtil.h"

@implementation ActionSheetUtil

-(void)actionSheetForAddingPhotosInView:(UIView *)view {
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select.."
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Gallery", @"Cancel", nil];
    [self.actionSheet showInView:view];
}

#pragma mark ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self.actionSheetDelegate showCamera];
            break;
        case 1:
            [self.actionSheetDelegate showGallery];
            break;
        default:
            break;
    }
}

@end
