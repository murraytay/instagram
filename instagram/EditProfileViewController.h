//
//  EditProfileViewController.h
//  instagram
//
//  Created by Taylor Murray on 7/11/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse.h"
#import "Comment.h"
#import "ParseUI.h"
@protocol EditProfileViewControllerDelegate
-(void)saveInfoWithImage:(UIImage *)image bio:(NSString *)bio name:(NSString *)name;
@end
@interface EditProfileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) id<EditProfileViewControllerDelegate> delegate;
@end
