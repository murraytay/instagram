//
//  MainFeedViewController.m
//  instagram
//
//  Created by Taylor Murray on 7/9/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "MainFeedViewController.h"
#import "Post.h"
#import "Parse.h"
#import "FeedCell.h"
#import "DetailViewController.h"
#import "DateTools.h"
#import "ParseUI.h"
@interface MainFeedViewController ()
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (strong, nonatomic) NSArray *feedPosts;
@property (strong,nonatomic) UIRefreshControl *refreshControl;

@end

@implementation MainFeedViewController

NSString *HeaderViewIdentifier = @"TableViewHeaderView";

- (IBAction)logoutAction:(UIBarButtonItem *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if(error == nil){
            [self dismissViewControllerAnimated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"hey we did it");
        } else{
            NSLog(@"error in logging out");
        }
    }];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.feedPosts.count;
}

- (IBAction)createAction:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"create-segue" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
    [self.feedTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:HeaderViewIdentifier];

    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPostsScroll) forControlEvents:UIControlEventValueChanged];
    [self.feedTableView insertSubview:self.refreshControl atIndex:0];
    [self fetchPosts];
    //[self.feedTableView reloadData];
}

-(void)fetchPostsScroll{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * posts, NSError * _Nullable error) {
        if(posts){
            self.feedPosts = posts;
            NSLog(@"we got the posts 😊");
        } else{
            NSLog(@"didn't get posts 🙃");
        }
        [self.feedTableView reloadData];
        [self.refreshControl endRefreshing];
    }];
    
}

-(void)fetchPosts{
    PFQuery *query = [Post query];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];

    query.limit = 20;

    [query findObjectsInBackgroundWithBlock:^(NSArray * posts, NSError * _Nullable error) {
        if(posts){
            self.feedPosts = posts;
            NSLog(@"we got the posts 😊");
        } else{
            NSLog(@"didn't get posts 🙃");
        }
        [self.feedTableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    
    Post *post = self.feedPosts[indexPath.section];
    [cell layoutCell:post];
    
    
    NSLog(@"%@", cell.captionLabel.text);
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderViewIdentifier];
    Post *post = self.feedPosts[section];
    //headerView.textLabel.text = post.author.username;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    
    /* Section header is in 0th index... */
    [label setText:post.author.username];
    [view addSubview:label];
    PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];

    
    if(post.author[@"picture_file"] != nil){
        imageView.file = (PFFile *)post.author[@"picture_file"];
        [imageView loadInBackground];
    } else{
        imageView.image = [UIImage imageNamed:@"profile_tab.png"];
    }
    
    //imageView. = imageView.frame.size.width/2;
    //imageView.clipsToBounds = TRUE;
    
    [view addSubview: imageView];
    return view;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"detail-segue"]){
         
         FeedCell *tappedCell = sender;
         
         NSIndexPath *indexPath = [self.feedTableView indexPathForCell:tappedCell];
         Post *thisPost = self.feedPosts[indexPath.section];
         UINavigationController *navigationController = [segue destinationViewController];
         DetailViewController *detailViewController = (DetailViewController *)navigationController.topViewController;
         
         
         
         detailViewController.post = thisPost;
         
         //DATE STUFF
         
         
         
     }
 }


@end

