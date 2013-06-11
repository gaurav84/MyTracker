//
//  PhotoView.m
//  MyTracker
//
//  Created by Gaurav Srivastava on 06/06/13.
//  Copyright (c) 2013 Gaurav Srivastava. All rights reserved.
//

#import "PhotoView.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#pragma mark Showing image with NSData

-(void)showImageWithData:(NSData *)data {
    self.image = [UIImage imageWithData:data];
}

#pragma mark Showing image with URL

-(void)showImageWithUrl:(NSURL *)url {
    
    /*
     Below code is copied from - http://stackoverflow.com/a/10799693/1125968
     */
    
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        Byte *buffer = (Byte*)malloc(rep.size);
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
        self.image = [UIImage imageWithData:data];
    } failureBlock:^(NSError *err) {
        NSLog(@"Error: %@",[err localizedDescription]);
    }];
}


@end
