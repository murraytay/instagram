//
//  ProfileViewController.h
//  instagram
//
//  Created by Taylor Murray on 7/10/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "EditProfileViewController.h"
#import "Comment.h"
@interface ProfileViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate, EditProfileViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *postsLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *profileCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *bioLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) IBOutlet PFImageView *profilePicView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) PFUser *user;
@end
