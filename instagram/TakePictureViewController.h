//
//  TakePictureViewController.h
//  instagram
//
//  Created by Taylor Murray on 7/9/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePictureViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *createPicView;

@property (weak, nonatomic) IBOutlet UITextField *captionTextfield;

@end
