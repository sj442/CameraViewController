
#import "EPCameraViewController.h"

static CGFloat a4letterRatio = 8.27/11.02;

static CGFloat businessCardRatio = 2/3.5;

@interface EPCameraViewController ()

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (weak, nonatomic) UIView *containerView;

@property (weak, nonatomic) UIView *buttonView;

@property (weak, nonatomic) UIView *mainOverlayView;

@end

@implementation EPCameraViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  UIView *containerView = [UIView new];
  [self.view addSubview:containerView];
  self.containerView = containerView;
  CGRect frame = CGRectZero;
  frame.origin.x = 0;
  frame.origin.y = 42;
  frame.size.width = CGRectGetWidth(self.view.frame);
  frame.size.height = CGRectGetHeight(self.view.frame)-42;
  containerView.frame =frame;
  
  [self addImagePickerController];
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

#pragma mark - Layout

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

- (UIView *)createCustomOverlayView
{
  UIView *mainOverlayView = [[UIView alloc] initWithFrame:self.view.bounds];
  self.mainOverlayView = mainOverlayView;
  
  [self setupCameraFrame];
  
  UIView *buttonView = [UIView new];
  buttonView.backgroundColor = [UIColor blackColor];
  [mainOverlayView addSubview:buttonView];
  self.buttonView = buttonView;
  CGRect frame = CGRectZero;
  frame.origin.x = 0;
  frame.origin.y = CGRectGetMaxY(mainOverlayView.frame)-100-64;
  frame.size.width = CGRectGetWidth(self.view.frame);
  frame.size.height = 100;
  buttonView.frame =frame;
  
  [self setupCameraButton];

  [self setupFlashButton];
  
  return mainOverlayView;
}

- (void)setupCameraFrame
{
  CGFloat cameraHeight = CGRectGetHeight(self.view.frame)-64-100;
  CGFloat lineViewHeight = cameraHeight - 50;
  CGFloat lineViewWidth;
  switch (self.documentType) {
    case 1:
      lineViewWidth = lineViewHeight*businessCardRatio;
      break;
      
    default:
      lineViewWidth = lineViewHeight*a4letterRatio;
      break;
  }
  CGFloat xOrigin = (320- lineViewWidth-10)/2;
  
  UIView *leftVerticalLine = [UIView new];
  leftVerticalLine.backgroundColor = [UIColor whiteColor];
  [self.mainOverlayView addSubview:leftVerticalLine];
  CGRect frame = CGRectZero;
  frame.origin.x = xOrigin;
  frame.origin.y = 25;
  frame.size.width = 5;
  frame.size.height = lineViewHeight;
  leftVerticalLine.frame = frame;
  
  UIView *rightVerticalLine = [UIView new];
  rightVerticalLine.backgroundColor = [UIColor whiteColor];
  [self.mainOverlayView addSubview:rightVerticalLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin+lineViewWidth+5;
  frame.origin.y = 25;
  frame.size.width = 5;
  frame.size.height = lineViewHeight;
  rightVerticalLine.frame =frame;
  
  UIView *leftUpperLine = [UIView new];
  leftUpperLine.backgroundColor = [UIColor whiteColor];
  [self.mainOverlayView addSubview:leftUpperLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin;
  frame.origin.y = 20;
  frame.size.width = 20;
  frame.size.height = 5;
  leftUpperLine.frame = frame;
  
  UIView *leftLowerLine = [UIView new];
  leftLowerLine.backgroundColor = [UIColor whiteColor];
  [self.mainOverlayView addSubview:leftLowerLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin;
  frame.origin.y = 20+lineViewHeight;
  frame.size.width = 20;
  frame.size.height = 5;
  leftLowerLine.frame = frame;
  
  UIView *rightUpperLine = [UIView new];
  rightUpperLine.backgroundColor = [UIColor whiteColor];
  [self.mainOverlayView addSubview:rightUpperLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin+lineViewWidth-10;
  frame.origin.y = 20;
  frame.size.width = 20;
  frame.size.height = 5;
  rightUpperLine.frame = frame;
  
  UIView *rightLowerLine = [UIView new];
  rightLowerLine.backgroundColor = [UIColor whiteColor];
  [self.mainOverlayView addSubview:rightLowerLine];
  frame = CGRectZero;
  frame.origin.x = xOrigin+lineViewWidth-10;
  frame.origin.y = 20+lineViewHeight;
  frame.size.width = 20;
  frame.size.height = 5;
  rightLowerLine.frame = frame;
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

#pragma mark- Action methods

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
  [self.delegate imageToBePassed:image];
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
