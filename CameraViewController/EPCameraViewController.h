//
//  ViewController.h
//  CameraViewController
//
//  Created by Sunayna Jain on 1/29/15.
//  Copyright (c) 2015 Enhatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EPCameraViewControllerDelegate <NSObject>

- (void)imageToBePassed:(UIImage *)image;

@end

@interface EPCameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) id <EPCameraViewControllerDelegate> delegate;

@end

