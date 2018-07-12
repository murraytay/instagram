//
//  CommentViewController.m
//  instagram
//
//  Created by Taylor Murray on 7/12/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCellTableViewCell.h"
#import "Comment.h"
@interface CommentViewController ()
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) IBOutlet PFImageView *currentUserProfilePic;
@property (strong, nonatomic) IBOutlet UIButton *postCommentButton;
@property (strong, nonatomic) IBOutlet UITextField *commentTextField;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    
    self.user = PFUser.currentUser;
    // Do any additional setup after loading the view.
    if(self.user[@"picture_file"] != nil){
        self.currentUserProfilePic.file = self.user[@"picture_file"];
        [self.currentUserProfilePic loadInBackground];
    } else{
        self.currentUserProfilePic.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    [self.commentTableView reloadData];
    
}
- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postCommentAction:(UIButton *)sender {
    //Comment *comment = [Comment initWithText:self.commentTextField.text];
    NSMutableArray *oldArray = [NSMutableArray arrayWithArray:self.post.comments];
    //[oldArray addObject:comment];
    [oldArray addObject:self.commentTextField.text];
    NSArray *myArray = [NSArray arrayWithArray:oldArray];
    self.post.comments = myArray;
    self.post.commentCount = [NSNumber numberWithInteger:[self.post.commentCount integerValue] + 1];
    
    
    
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"we freaking succeeded!");
        }
        [self.commentTableView reloadData];
    }];
    
    self.commentTextField.text = @"";
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCellTableViewCell"];
    
//    Comment *currentComment = self.post.comments[indexPath.row];
//    cell.commentLabel.text = currentComment.text;
//    cell.profileCommentPicView.file = currentComment.user[@"picture_file"];
//    [cell.profileCommentPicView loadInBackground];
//    cell.usernameLabel.text = currentComment.user.username;
    NSString *currentComment = self.post.comments[indexPath.row];
    cell.commentLabel.text = currentComment;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.post.comments.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
