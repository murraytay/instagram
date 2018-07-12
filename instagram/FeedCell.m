//
//  feedCell.m
//  instagram
//
//  Created by Taylor Murray on 7/9/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapLike:(UIButton *)sender {
    if(self.post.liked){
        self.post.liked = NO;
        self.post.likeCount = [NSNumber numberWithInteger:([self.post.likeCount integerValue]-1)];
    } else{
        self.post.liked = YES;
        self.post.likeCount = [NSNumber numberWithInteger:([self.post.likeCount integerValue]+1)];
        
    }
    
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
    }];
    
    [self layoutCell:self.post];
}
- (IBAction)didTapComment:(UIButton *)sender {
    
}

- (void)layoutCell:(Post *)post {
    self.post = post;
    self.imageFeedView.file = post[@"image"];
    [self.imageFeedView loadInBackground];
    
    self.likesCountLabel.text = [self.post.likeCount stringValue];
    self.captionLabel.text = self.post.caption;
    
    if(self.post.liked){
        [self.likeButton setImage:[UIImage imageNamed:@"Webp.net-resizeimage (4)"] forState:UIControlStateNormal];
    } else{
        [self.likeButton setImage:[UIImage imageNamed:@"Webp.net-resizeimage"] forState:UIControlStateNormal];
        
    }
    
}

@end
