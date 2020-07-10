//
//  CameraViewController.m
//  Instagram
//
//  Created by Nikesh Subedi on 7/7/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import "ComposeViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "DetailsViewController.h"


@interface ComposeViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *captionField;
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
}
- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];

}
- (IBAction)addPhotos:(id)sender {
   UIImagePickerController *imagePickerVC = [UIImagePickerController new];

          
        
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
       imagePickerVC.delegate = self;
       imagePickerVC.allowsEditing = YES;

       [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (IBAction)useCamera:(id)sender {
  UIImagePickerController *imagePickerVC = [UIImagePickerController new];

   imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
       imagePickerVC.delegate = self;
       imagePickerVC.allowsEditing = YES;

       [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    //UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    editedImage = [self resizeImage:editedImage withSize:CGSizeMake((1-(editedImage.size.height-500)/editedImage.size.height)*editedImage.size.width, 500)];
    // Do something with the images (based on your use case)
    [self.previewImage setImage:editedImage];
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)postPressed:(id)sender {
    [Post postUserImage:self.previewImage.image withCaption:self.captionField.text withCompletion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
