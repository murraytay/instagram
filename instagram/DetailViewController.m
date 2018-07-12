//
//  DetailViewController.m
//  instagram
//
//  Created by Taylor Murray on 7/10/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "DetailViewController.h"
#import "DateTools.h"
#import "ParseUI.h"
#import "Post.h"
#import "CommentViewController.h"
@interface DetailViewController ()


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUIMine];
}
- (IBAction)commentAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"commentSegue" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setUIMine{
    self.captionLabel.text = self.post.caption;
    self.likesCountLabel.text = [self.post.likeCount stringValue];
    
    NSDate *createdAtOriginalString = self.post.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //Configure the input format to parse the date
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    //Convert String to Date
    //NSDate *date = [formatter dateFromString:createdAtOriginalString];
    
    self.dateLabel.text = createdAtOriginalString.timeAgoSinceNow;
    
    self.imageDetailView.file = self.post[@"image"];
    [self.imageDetailView loadInBackground];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"commentSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        CommentViewController *commentViewController = (CommentViewController *)navigationController.topViewController;
        commentViewController.post = self.post;
    }
}


@end
