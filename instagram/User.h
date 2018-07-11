//
//  User.h
//  instagram
//
//  Created by Taylor Murray on 7/11/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "PFUser.h"
#import "ParseUI.h"
#import <Parse.h>
@interface User : PFUser
@property (strong,nonatomic) NSString * _Nullable username;
@property (strong, nonatomic) NSString * _Nullable password;
@property (strong, nonatomic) NSString * _Nullable name;
@property (strong, nonatomic, nullable) PFFile *profilePicture;

+ (User *_Nonnull) myInitUser:(PFUser *_Nonnull)userPF;

+ (User *_Nonnull)getCurrentUser;
+ (PFFile *_Nullable)getPFFileFromImage:(UIImage *_Nullable)image;
@end
