//
//  ManagePhotosViewController.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 05/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "ManagePhotosViewController.h"
#import "ImageVO.h"
#import "AlertUtil.h"

@interface ManagePhotosViewController ()

@end

@implementation ManagePhotosViewController

#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpGestures];
    [self setUpNotifications];
}

-(void)viewWillAppear:(BOOL)animated {
    selectedPhotoIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    AppLog(@"Received memory warning!");
}

#pragma mark Notifications

-(void)setUpNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didStartCopyImagesFromGallery:)
                                                 name:@"COPY_IMAGES"
                                               object:nil];
}


#pragma mark Notifcation handler

-(void)didStartCopyImagesFromGallery:(NSNotification *)notification {
    AppLog(@"START");
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    progressView = [[ProgressView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/4, 0, 0)];
    
    [window addSubview:progressView];

}

#pragma mark Gestures setup

-(void)setUpGestures {
    UITapGestureRecognizer *cameraGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cameraImageViewTouched:)];
    [cameraImageView addGestureRecognizer:cameraGestureRecognizer];
    [cameraImageView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *galleryGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(galleryImageViewTouched:)];
    [galleryImageView addGestureRecognizer:galleryGestureRecognizer];
    [galleryImageView setUserInteractionEnabled:YES];
}

#pragma mark Camera gesture handler

-(void)cameraImageViewTouched:(UITapGestureRecognizer *)gesture {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        [self presentModalViewController:imagePickerController animated:YES];
    }
    else {
        [AlertUtil showAlertWithMessage:@"Camera not found"];
    }
    
}

#pragma mark Local gallery gesture handler

-(void)galleryImageViewTouched:(UITapGestureRecognizer *)gesture {
    
    photoGalleryManager = [[PhotoGalleryManager alloc] init];
    photoGalleryManager.delegate = self;
    [photoGalleryManager showGalleryPhotosInViewController:self];
}

#pragma mark UIImagePickerController delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
                         
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"])];
        [self.allPhotosDisplayView showImage:imageData];
        [picker dismissModalViewControllerAnimated:YES];
    }
    
//    ImageVO *imageVO = [[ImageVO alloc] init];
//    imageVO.ref = imageData;
//    [self.capturedDetailsVO.listOfPhotos addObject:imageVO];

//    self.allPhotosDisplayView.source = self.capturedDetailsVO.listOfPhotos;
//    [self.allPhotosDisplayView refreshView];
}

#pragma mark PhotoGalleryManger delegate

-(void)didFinishPickingImages:(NSArray *)selectedPhotos {
    NSArray *params = [NSArray arrayWithObjects:[NSNumber numberWithInt:selectedPhotoIndex], selectedPhotos, nil];
    [self func:params];

}

-(void)func:(NSArray *)params {
    NSArray *selectedPhotos = [params objectAtIndex:1];
    int sPhotoIndex = [[params objectAtIndex:0] intValue];
    UIImage *image = [selectedPhotos objectAtIndex:sPhotoIndex];
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
    [self.allPhotosDisplayView showImage:imageData];
    selectedPhotoIndex ++;
    progressView.progressLabel.text = [NSString stringWithFormat:@"Copying %d / %d", sPhotoIndex + 1, [selectedPhotos count]];
    
    if(sPhotoIndex == ([selectedPhotos count] - 1)) {
        [self dismissModalViewControllerAnimated:YES];
        [progressView removeFromSuperview];
    }
    else {
        
        NSArray *params = [NSArray arrayWithObjects:[NSNumber numberWithInt:selectedPhotoIndex], selectedPhotos, nil];
        [self performSelector:@selector(func:) withObject:params afterDelay:0.01];
    }

}



-(void)didCancel {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark

@end
