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
  self.navigationController.navigationBarHidden = YES;
  UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-40)];
  [self.view addSubview:containerView];
  self.containerView = containerView;
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
  imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  imagePicker.showsCameraControls = NO;
  imagePicker.navigationItem.rightBarButtonItem = nil;
  imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
  imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
  [self addChildViewController:imagePicker];
  [self.containerView addSubview:imagePicker.view];
  [imagePicker didMoveToParentViewController:self];
  imagePicker.view.bounds = self.containerView.bounds;
  self.imagePicker = imagePicker;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];

  UIView *overlay_view = [self createCustomOverlayView];
  [self.imagePicker setCameraOverlayView:overlay_view];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (UIView *)createCustomOverlayView
{
  
  // Main overlay view created
  UIView *main_overlay_view = [[UIView alloc] initWithFrame:self.view.bounds];
  
  // Clear view (live camera feed) created and added to main overlay view
  // ------------------------------------------------------------------------
  UIView *clear_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100-40)];
  clear_view.opaque = NO;
  clear_view.backgroundColor = [UIColor clearColor];
  CGFloat cameraHeight = CGRectGetHeight(clear_view.frame);
  CGFloat lineViewHeight = cameraHeight - 50;
  CGFloat lineViewWidth = lineViewHeight*8.27/11.02;
  CGFloat xOrigin = (320- lineViewWidth-10)/2;
  UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin, 25, 5, lineViewHeight)];
  UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin+lineViewWidth+5, 25, 5, lineViewHeight)];
  UIView *leftUpperLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin, 20, 20, 5)];
  leftUpperLine.backgroundColor = [UIColor redColor];
  [clear_view addSubview:leftUpperLine];
  UIView *leftLowerLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin, 20+lineViewHeight, 20, 5)];
  leftLowerLine.backgroundColor = [UIColor redColor];
  [clear_view addSubview:leftLowerLine];
  UIView *rightUpperLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin+lineViewWidth-10, 20, 20, 5)];
  rightUpperLine.backgroundColor = [UIColor redColor];
  [clear_view addSubview:rightUpperLine];
  UIView *rightLowerLine = [[UIView alloc]initWithFrame:CGRectMake(xOrigin+lineViewWidth-10, 20+lineViewHeight, 20, 5)];
  rightLowerLine.backgroundColor = [UIColor redColor];
  [clear_view addSubview:rightLowerLine];

  rightLine.backgroundColor = [UIColor redColor];
  leftLine.backgroundColor = [UIColor redColor];
  [clear_view addSubview:rightLine];
  [clear_view addSubview:leftLine];
  [main_overlay_view addSubview:clear_view];
  // ------------------------------------------------------------------------
  
  UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-50, CGRectGetHeight(self.view.frame)-100-40, 100, 100)];
  [cameraButton setTitle:@"camera" forState:UIControlStateNormal];
  [cameraButton addTarget:self action:@selector(cameraButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  cameraButton.backgroundColor = [UIColor redColor];
  [main_overlay_view addSubview:cameraButton];
  
  UIButton *flashButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-50, CGRectGetHeight(self.view.frame)-72-44, 44, 44)];
  [flashButton setTitle:@"off" forState:UIControlStateNormal];
  [flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  flashButton.backgroundColor = [UIColor redColor];
  [main_overlay_view addSubview:flashButton];
  return main_overlay_view;
}

- (void)cameraButtonPressed:(id)sender
{
  [self.imagePicker takePicture];
}

- (void)flashButtonPressed:(id)sender
{
  if (self.imagePicker.cameraFlashMode== UIImagePickerControllerCameraFlashModeOff) {
    self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
  } else {
    self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
  }
}

@end
