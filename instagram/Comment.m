//
//  Comment.m
//  instagram
//
//  Created by Taylor Murray on 7/12/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "Comment.h"


@implementation Comment
@dynamic username;
//@dynamic profilePicImage;
@dynamic text;
@dynamic caption;
@dynamic createdAt;
@dynamic file;

+(Comment *)initWithText:(NSString *)myString andPostCaption:(NSString *)caption{
    Comment *comment = [Comment new];
    
    PFUser *instace = PFUser.currentUser;
    comment.username = instace.username;
    
    if(instace[@"picture_file"]){
        comment.file = instace[@"picture_file"];
    }
    
    
    comment.caption = caption;
    comment.text = myString;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    comment.createdAt = [NSDate date];
    return comment;
}
+ (nonnull NSString *)parseClassName {
    return @"Comment";
}


@end
