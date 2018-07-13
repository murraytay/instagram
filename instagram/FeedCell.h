//
//  feedCell.h
//  instagram
//
//  Created by Taylor Murray on 7/9/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "ParseUI.h"
#import "Comment.h"
@interface FeedCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet PFImageView *imageFeedView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong,nonatomic) Post *post;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *likesCountLabel;
- (void)layoutCell:(Post *)post;
@end

