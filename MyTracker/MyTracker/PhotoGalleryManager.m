//
//  PhotoGalleryManager.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 12/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "PhotoGalleryManager.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"

@implementation PhotoGalleryManager

#pragma mark Show Gallery

-(void)showGalleryPhotosInViewController:(UIViewController *)viewController {
    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] init];
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    
    [albumController setParent:elcPicker];
    [elcPicker setDelegate:self];
    
    [viewController presentModalViewController:elcPicker animated:YES];
}

#pragma mark ELCImagePickerController delegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    if([info count] > 0)
        [self.delegate didFinishPickingImages:[info valueForKey:@"UIImagePickerControllerOriginalImage"]];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    [self.delegate didCancel];
}

#pragma mark

@end
