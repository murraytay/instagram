//
//  Comment.m
//  instagram
//
//  Created by Taylor Murray on 7/12/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "Comment.h"

@implementation Comment
+(Comment *)initWithText:(NSString *)myString{
    Comment *comment = [Comment new];
    
    comment.user = PFUser.currentUser;
    comment.text = myString;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    comment.createdAt = [NSDate date];
    return comment;
}
@end
