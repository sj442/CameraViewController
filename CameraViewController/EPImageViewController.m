
#import "EPImageViewController.h"

@interface EPImageViewController ()

@property (weak, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIImage *image;

@end

@implementation EPImageViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  UIImageView *iv = [UIImageView new];
  [self.view addSubview:iv];
  self.imageView = iv;
  CGRect frame = CGRectZero;
  frame.origin.x = 0;
  frame.origin.y = 64;
  frame.size.width = CGRectGetWidth(self.view.frame);
  frame.size.height = CGRectGetHeight(self.view.frame)-64-44;
  iv.frame = frame;
  
  UIButton *cameraButton = [UIButton new];
  cameraButton.backgroundColor = [UIColor blackColor];
  [cameraButton setTitle:@"Camera" forState:UIControlStateNormal];
  [cameraButton addTarget:self action:@selector(cameraButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:cameraButton];
  frame = CGRectZero;
  frame.origin.x = 0;
  frame.origin.y = CGRectGetMaxY(iv.frame);
  frame.size.width = CGRectGetWidth(self.view.frame);
  frame.size.height = 44;
  cameraButton.frame =frame;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Action methods

- (void)cameraButtonPressed:(id)sender
{
  EPCameraViewController *cameraVC = [[EPCameraViewController alloc]init];
  cameraVC.documentType = EPDocumentTypeBusinessCard;
  cameraVC.delegate = self;
  [self.navigationController presentViewController:cameraVC animated:YES completion:nil];
}

#pragma mark - EPImageviewControllerDelegate methods

- (void)imageToBePassed:(UIImage *)image
{
  self.image = image;
}

@end
