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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    AppLog(@"Received memory warning!");
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
//    imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentModalViewController:imagePickerController animated:YES];
    
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
    for(int i=0; i<[selectedPhotos count]; i++) {
        UIImage *image = [selectedPhotos objectAtIndex:i];
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        [self.allPhotosDisplayView showImage:imageData];
    }
    [self dismissModalViewControllerAnimated:YES];

}

-(void)didCancel {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark

@end
