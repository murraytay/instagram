//
//  ProfileViewController.h
//  instagram
//
//  Created by Taylor Murray on 7/10/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
@interface ProfileViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *profileCollectionView;

@property (strong, nonatomic) IBOutlet PFImageView *profilePicView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@end
