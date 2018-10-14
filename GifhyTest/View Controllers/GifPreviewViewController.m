//
//  GifPreviewViewController.m
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import "GifPreviewViewController.h"
#import <AnimatedGIFImageSerialization/AnimatedGIFImageSerialization.h>
#import <Photos/Photos.h>

@interface GifPreviewViewController () {
    NSData *imageData;
}

@end

@implementation GifPreviewViewController
@synthesize gif;
@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator setCenter: imageView.center];
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    NSURLRequest * request = [NSURLRequest requestWithURL:gif.gifhyImageOriginal.url];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        self->imageData = data;
        UIImage * image = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self->imageView.image = image;
            [activityIndicator removeFromSuperview];
        }];
    }] resume];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveImage)];
    self.navigationItem.rightBarButtonItem = bbi;
}

-(void)saveImage {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
        [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:self->imageData options:options];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlert];
            });
        }
        else {
            NSLog(@"error saving to photos: %@", error);
        }
    }];
}

-(void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Great Success" message:@"The image was saved to camera roll" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
