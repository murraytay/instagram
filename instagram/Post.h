//
//  Post.h
//  instagram
//
//  Created by Taylor Murray on 7/9/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse.h>
#import "User.h"
#import "Comment.h"
@interface Post : PFObject<PFSubclassing>

@property (nonatomic,strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFile *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *commentsClass;
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic) NSArray *likedBy;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+(PFFile *)getPFFileFromImage:(UIImage *_Nullable)image;
@end
