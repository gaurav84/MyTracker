//
//  ManagePhotosViewController.h
//  MyTracker
//
//  Created by Gaurav Srivastava on 05/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapturedDetailsVO.h"
#import "AllPhotosDisplayView.h"
#import "PhotoGalleryManager.h"
#import "ProgressView.h"

@interface ManagePhotosViewController : UIViewController <UINavigationControllerDelegate,
                                                            UIImagePickerControllerDelegate,
                                                            PhotoGalleryManagerDelegate> {
    PhotoGalleryManager *photoGalleryManager;
    ProgressView *progressView;
                                                                UIView *yourSubView;
                                                                
    // IBOutlet
    IBOutlet UIScrollView *photosScroller;
    IBOutlet UIImageView *cameraImageView;
    IBOutlet UIImageView *galleryImageView;
}

@property (nonatomic, retain) CapturedDetailsVO *capturedDetailsVO;
@property (nonatomic, retain) NSArray *params;
// IBOutlet
@property (nonatomic, retain) IBOutlet AllPhotosDisplayView *allPhotosDisplayView;

@end
