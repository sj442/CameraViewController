
#import <UIKit/UIKit.h>

@protocol EPCameraViewControllerDelegate <NSObject>

- (void)imageToBePassed:(UIImage *)image;

@end

typedef NS_ENUM(NSInteger, EPDocumentType){
  EPDocumentTypeA4Size,
  EPDocumentTypeBusinessCard
};

@interface EPCameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) id <EPCameraViewControllerDelegate> delegate;

@property (nonatomic) EPDocumentType documentType;

@end

