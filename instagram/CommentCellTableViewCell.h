//
//  CommentCellTableViewCell.h
//  instagram
//
//  Created by Taylor Murray on 7/12/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "Comment.h"
@interface CommentCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet PFImageView *profileCommentPicView;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;

@end
