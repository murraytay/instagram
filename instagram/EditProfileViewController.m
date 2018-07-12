//
//  EditProfileViewController.m
//  instagram
//
//  Created by Taylor Murray on 7/11/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Post.h"

@interface EditProfileViewController ()

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) IBOutlet UITextField *bioTextfield;
@property (strong, nonatomic) IBOutlet PFImageView *editProfileImageView;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) NSString *bio;
@end

@implementation EditProfileViewController
- (IBAction)doneButton:(UIBarButtonItem *)sender {
    
    self.name = self.nameTextField.text;
    self.bio = self.bioTextfield.text;
    if(self.image == nil){
        self.image = self.editProfileImageView.image;
    }
    
    [self.delegate saveInfoWithImage:self.image bio:self.bio name:self.name];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFUser *user = PFUser.currentUser;
    
    if(user[@"name"] != nil){
        self.nameTextField.text = user[@"name"];
    } else {
        self.nameTextField.text = @"";
    }
    
    if(user[@"bio"] != nil){
        self.bioTextfield.text = user[@"bio"];
    } else {
        self.bioTextfield.text = @"";
    }
    
    if(user[@"picture_file"] != nil){
        self.editProfileImageView.file = user[@"picture_file"];
        [self.editProfileImageView loadInBackground];
    } else{
        UIImage *imageBoring = [UIImage imageNamed:@"profile_tab"];
        self.editProfileImageView.image = imageBoring;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    CGSize safeSize = CGSizeMake(1024, 728);
    
    self.image = [self resizeImage:originalImage withSize:safeSize];
    
    self.editProfileImageView.image = self.image;
    
    // Do something with the images (based on your use case)
    //self.profilePicView.image = self.image;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)changePicAction:(UIButton *)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
