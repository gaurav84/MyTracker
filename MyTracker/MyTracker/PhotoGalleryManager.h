//
//  PhotoGalleryManager.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 12/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELCImagePickerController.h"

@protocol PhotoGalleryManagerDelegate <NSObject>

-(void)didFinishPickingImages:(NSArray *)selectedPhotos;
-(void)didCancel;

@end

@interface PhotoGalleryManager : NSObject <ELCImagePickerControllerDelegate>

@property (nonatomic, retain) id<PhotoGalleryManagerDelegate> delegate;
@property (nonatomic, retain) UIView *containerView;

-(void)showGalleryPhotosInViewController:(UIViewController *)viewController;

@end
