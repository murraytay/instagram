//
//  feedCell.m
//  instagram
//
//  Created by Taylor Murray on 7/9/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "FeedCell.h"
#import "DateTools.h"
@implementation FeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.user = PFUser.currentUser;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapLike:(UIButton *)sender {
    
    BOOL liked = NO;
    for(NSString *username in self.post.likedBy){
        if([self.user.username isEqualToString:username]){
            liked = YES;
        }
    }
    
    if(liked){
        NSMutableArray *oldArray = [NSMutableArray arrayWithArray:self.post.likedBy];
        [oldArray removeObject:self.user.username];
        NSArray *myArray = [NSArray arrayWithArray:oldArray];
        self.post.likedBy = myArray;
        self.post.likeCount = [NSNumber numberWithInteger:([self.post.likeCount integerValue]-1)];
    } else{
        
        NSMutableArray *oldArray = [NSMutableArray arrayWithArray:self.post.likedBy];
        [oldArray addObject:self.user.username];
        NSArray *myArray = [NSArray arrayWithArray:oldArray];
        self.post.likedBy = myArray;
        
        self.post.likeCount = [NSNumber numberWithInteger:([self.post.likeCount integerValue]+1)];
        
    }
    
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
    }];
    
    [self layoutCell:self.post];
}


- (void)layoutCell:(Post *)post {
    self.post = post;
    self.imageFeedView.file = post[@"image"];
    [self.imageFeedView loadInBackground];
    
    self.likesCountLabel.text = [self.post.likeCount stringValue];
    self.captionLabel.text = self.post.caption;
    
    BOOL liked = NO;
    for(NSString *username in self.post.likedBy){
        if([self.user.username isEqualToString:username]){
            liked = YES;
        }
    }
    
    if(liked){
        [self.likeButton setImage:[UIImage imageNamed:@"Webp.net-resizeimage (4)"] forState:UIControlStateNormal];
    } else{
        [self.likeButton setImage:[UIImage imageNamed:@"Webp.net-resizeimage"] forState:UIControlStateNormal];
        
    }
    self.dateLabel.text = self.post.createdAt.timeAgoSinceNow;
    
}

@end
