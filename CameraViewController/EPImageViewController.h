//
//  EPImageViewController.h
//  CameraViewController
//
//  Created by Sachin Jindal on 2/2/15.
//  Copyright (c) 2015 Enhatch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPCameraViewController.h"

@interface EPImageViewController : UIViewController <EPCameraViewControllerDelegate>

@property (strong, nonatomic) UIImage *image;

@end
