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

@interface ManagePhotosViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    IBOutlet UIScrollView *photosScroller;
    IBOutlet UIImageView *cameraImageView;
    IBOutlet UIImageView *galleryImageView;
}

@property (nonatomic, retain) CapturedDetailsVO *capturedDetailsVO;

// IBOutlet
@property (nonatomic, retain) IBOutlet AllPhotosDisplayView *allPhotosDisplayView;

@end
