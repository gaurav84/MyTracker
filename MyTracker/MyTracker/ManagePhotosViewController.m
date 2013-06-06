//
//  ManagePhotosViewController.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 05/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "ManagePhotosViewController.h"
#import "ImageVO.h"

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
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentModalViewController:imagePicker animated:YES];
}

#pragma mark Local gallery gesture handler

-(void)galleryImageViewTouched:(UITapGestureRecognizer *)gesture {
    
}

#pragma mark UIImagePickerController delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];

    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"])];
    
    [self.allPhotosDisplayView showImageWithData:imageData];
    
//    ImageVO *imageVO = [[ImageVO alloc] init];
//    imageVO.ref = imageData;
//    [self.capturedDetailsVO.listOfPhotos addObject:imageVO];

//    self.allPhotosDisplayView.source = self.capturedDetailsVO.listOfPhotos;
//    [self.allPhotosDisplayView refreshView];
}

#pragma mark 

@end
