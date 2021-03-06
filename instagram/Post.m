//
//  Post.m
//  instagram
//
//  Created by Taylor Murray on 7/9/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "Post.h"

@implementation Post
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic likedBy;
@dynamic comments;
@dynamic commentsClass;
+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    newPost.likedBy = [[NSArray alloc] init];
    newPost.comments = [[NSArray alloc] init];
    
    [newPost saveInBackgroundWithBlock: completion];
    
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
@end
