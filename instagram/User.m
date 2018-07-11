//
//  User.m
//  instagram
//
//  Created by Taylor Murray on 7/11/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "User.h"

@implementation User
@dynamic username;
@dynamic password;
@dynamic profilePicture;
@dynamic name;


//+(nonnull NSString *)parseClassName{
//    return @"User";
//}

+ (User *) myInitUser:(PFUser *)userPF{
    
    User *newUser = [User new];
    //newPost.image = [self getPFFileFromImage:image];
    newUser.password = userPF.password;
    newUser.username = userPF.username;
    newUser.name = @"No name yet";
    UIImage *noProfPic = [UIImage imageNamed:@"profile_tab"];
    newUser.profilePicture = [self getPFFileFromImage:noProfPic];
    
    return newUser;
}

+(PFFile *)getPFFileFromImage:(UIImage *_Nullable)image{
    if(!image){
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    
    if(!imageData){
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}

+ (User *)getCurrentUser{
    User * user = (User *)[PFUser getCurrentUserInBackground];
    return user;
}
@end


