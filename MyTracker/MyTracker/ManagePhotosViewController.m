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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    AppLog(@"Received memory warning!");
}

-(void)setUpProgressView {
    progressView = [[ProgressView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    [photoGalleryManager.containerView addSubview:progressView];
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

    progressView = [[ProgressView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
//    [photoGalleryManager.containerView addSubview:progressView];

    UIWindow *wind = [[UIApplication sharedApplication] keyWindow];
    [wind addSubview:progressView];
    
    //[self setUpProgressView];
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
    int index = 0;
    for(int i=0; i<[selectedPhotos count]; i++) {
        UIImage *image = [selectedPhotos objectAtIndex:i];
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        [self.allPhotosDisplayView showImage:imageData];
        index ++;
        
        [progressView updateLabelWithProgress:[NSString stringWithFormat:@"%d / %d", index, [selectedPhotos count]]];
        AppLog(@"%d / %d DONE", index, [selectedPhotos count]);
    }
    [self dismissModalViewControllerAnimated:YES];
    AppLog(@"FINSIH");
    
    [progressView removeFromSuperview];
}

-(void)didCancel {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark


@end
