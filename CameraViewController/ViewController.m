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

@property (weak, nonatomic) UIView *buttonView;

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

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIView *)createCustomOverlayView
{
  UIView *mainOverlayView = [[UIView alloc] initWithFrame:self.view.bounds];
  
  CGFloat cameraHeight = CGRectGetHeight(self.view.frame)-64-100;
  CGFloat lineViewHeight = cameraHeight - 50;
  CGFloat lineViewWidth = lineViewHeight*8.27/11.02;
  CGFloat xOrigin = (320- lineViewWidth-10)/2;
  
  UIView *leftLine = [UIView new];
  leftLine.backgroundColor = [UIColor whiteColor];
  [mainOverlayView addSubview:leftLine];
  CGRect frame = CGRectZero;
  frame.origin.x = xOrigin;
  frame.origin.y = 25;
  frame.size.width = 5;
  frame.size.height = lineViewHeight;
  leftLine.frame = frame;
  
  UIView *rightLine = [UIView new];
  rightLine.backgroundColor = [UIColor whiteColor];
  [mainOverlayView addSubview:rightLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin+lineViewWidth+5;
  frame.origin.y = 25;
  frame.size.width = 5;
  frame.size.height = lineViewHeight;
  rightLine.frame =frame;
  
  UIView *leftUpperLine = [UIView new];
  leftUpperLine.backgroundColor = [UIColor whiteColor];
  [mainOverlayView addSubview:leftUpperLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin;
  frame.origin.y = 20;
  frame.size.width = 20;
  frame.size.height = 5;
  leftUpperLine.frame = frame;
  
  UIView *leftLowerLine = [UIView new];
  leftLowerLine.backgroundColor = [UIColor whiteColor];
  [mainOverlayView addSubview:leftLowerLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin;
  frame.origin.y = 20+lineViewHeight;
  frame.size.width = 20;
  frame.size.height = 5;
  leftLowerLine.frame = frame;
  
  UIView *rightUpperLine = [UIView new];
  rightUpperLine.backgroundColor = [UIColor whiteColor];
  [mainOverlayView addSubview:rightUpperLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin+lineViewWidth-10;
  frame.origin.y = 20;
  frame.size.width = 20;
  frame.size.height = 5;
  rightUpperLine.frame = frame;
  
  UIView *rightLowerLine = [UIView new];
  rightLowerLine.backgroundColor = [UIColor whiteColor];
  [mainOverlayView addSubview:rightLowerLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin+lineViewWidth-10;
  frame.origin.y = 20+lineViewHeight;
  frame.size.width = 20;
  frame.size.height = 5;
  rightLowerLine.frame = frame;
  
  UIView *buttonView = [UIView new];
  buttonView.backgroundColor = [UIColor blackColor];
  [mainOverlayView addSubview:buttonView];
  self.buttonView = buttonView;
  frame = CGRectZero;
  frame.origin.x = 0;
  frame.origin.y = CGRectGetMaxY(mainOverlayView.frame)-100-64;
  frame.size.width = CGRectGetWidth(self.view.frame);
  frame.size.height = 100;
  buttonView.frame =frame;
  
  [self setupCameraButton];

  [self setupFlashButton];
  
  return mainOverlayView;
}

- (void)setupCameraButton
{
  UIButton *cameraButton = [UIButton new];
  [cameraButton setImage:[UIImage imageNamed:@"whiteShutter"] forState:UIControlStateNormal];
  [cameraButton setImage:[UIImage imageNamed:@"grayShutter"] forState:UIControlStateHighlighted];
  [cameraButton addTarget:self action:@selector(cameraButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.buttonView addSubview:cameraButton];
  CGRect frame = CGRectZero;
  frame.origin.x = CGRectGetWidth(self.view.frame)/2-35;
  frame.origin.y = 15;
  frame.size.width = 70;
  frame.size.height = 70;
  cameraButton.frame = frame;
}

- (void)setupFlashButton
{
  UIButton *flashButton = [UIButton new];
  [flashButton setImage:[UIImage imageNamed:@"whiteFlash"] forState:UIControlStateNormal];
  [flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.buttonView addSubview:flashButton];
  CGRect frame = CGRectZero;
  frame.origin.x = CGRectGetWidth(self.view.frame)-50;
  frame.origin.y = 28;
  frame.size.width = 44;
  frame.size.height = 44;
  flashButton.frame = frame;
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
  // UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

@end
