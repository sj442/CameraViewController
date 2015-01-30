//
//  ViewController.m
//  CameraViewController
//
//  Created by Sunayna Jain on 1/29/15.
//  Copyright (c) 2015 Enhatch. All rights reserved.

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (weak, nonatomic) UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.title = @"Camera";
  UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-42)];
  [self.view addSubview:containerView];
  self.containerView = containerView;
  
  [self addImagePickerController];
}

- (void)addImagePickerController
{
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
  imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  imagePicker.showsCameraControls = NO;
  imagePicker.navigationItem.rightBarButtonItem = nil;
  imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
  imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
  imagePicker.delegate = self;
  self.imagePicker = imagePicker;
  
  [self addChildViewController:imagePicker];
  [self.containerView addSubview:imagePicker.view];
  [imagePicker didMoveToParentViewController:self];
  imagePicker.view.bounds = self.containerView.bounds;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  UIView *overlayView = [self createCustomOverlayView];
  [self.imagePicker setCameraOverlayView:overlayView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (UIView *)createCustomOverlayView
{
  UIView *mainOverlayView = [[UIView alloc] initWithFrame:self.view.bounds];
  UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 100)];
  clearView.opaque = NO;
  clearView.backgroundColor = [UIColor clearColor];
  [mainOverlayView addSubview:clearView];
  
  CGFloat cameraHeight = CGRectGetHeight(self.view.frame)-64-100;
  CGFloat lineViewHeight = cameraHeight - 50;
  CGFloat lineViewWidth = lineViewHeight*8.27/11.02;
  CGFloat xOrigin = (320- lineViewWidth-10)/2;
  
  UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin, 25, 5, lineViewHeight)];
  leftLine.backgroundColor = [UIColor whiteColor];
  [clearView addSubview:leftLine];
  
  UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin+lineViewWidth+5, 25, 5, lineViewHeight)];
  rightLine.backgroundColor = [UIColor whiteColor];
  [clearView addSubview:rightLine];
  
  UIView *leftUpperLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin, 20, 20, 5)];
  leftUpperLine.backgroundColor = [UIColor whiteColor];
  [clearView addSubview:leftUpperLine];
  
  UIView *leftLowerLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin, 20+lineViewHeight, 20, 5)];
  leftLowerLine.backgroundColor = [UIColor whiteColor];
  [clearView addSubview:leftLowerLine];
  
  UIView *rightUpperLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin+lineViewWidth-10, 20, 20, 5)];
  rightUpperLine.backgroundColor = [UIColor whiteColor];
  [clearView addSubview:rightUpperLine];
  
  UIView *rightLowerLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin+lineViewWidth-10, 20+lineViewHeight, 20, 5)];
  rightLowerLine.backgroundColor = [UIColor whiteColor];
  [clearView addSubview:rightLowerLine];
  
  UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mainOverlayView.frame)-100-64, CGRectGetWidth(self.view.frame), 100)];
  buttonView.backgroundColor = [UIColor blackColor];
  [mainOverlayView addSubview:buttonView];
  
  UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-35, 15, 70, 70)];
  [cameraButton setImage:[UIImage imageNamed:@"whiteShutter"] forState:UIControlStateNormal];
  [cameraButton setImage:[UIImage imageNamed:@"grayShutter"] forState:UIControlStateHighlighted];
  [cameraButton addTarget:self action:@selector(cameraButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [buttonView addSubview:cameraButton];
  
  UIButton *flashButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-50, 28, 44, 44)];
  [flashButton setImage:[UIImage imageNamed:@"whiteFlash"] forState:UIControlStateNormal];
  [flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [buttonView addSubview:flashButton];
  
  return mainOverlayView;
}

- (void)cameraButtonPressed:(id)sender
{
  [self.imagePicker takePicture];
}

- (void)flashButtonPressed:(id)sender
{
  UIButton *button = (UIButton *)sender;
  if (self.imagePicker.cameraFlashMode== UIImagePickerControllerCameraFlashModeOff) {
    self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    [button setImage:[UIImage imageNamed:@"yellowFlash"] forState:UIControlStateNormal];
  } else {
    self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    [button setImage:[UIImage imageNamed:@"whiteFlash"] forState:UIControlStateNormal];
  }
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

@end
