//
//  ProfileViewController.m
//  instagram
//
//  Created by Taylor Murray on 7/10/18.
//  Copyright © 2018 Taylor Murray. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse.h"
#import "Post.h"
#import "ProfileCollectionCell.h"
#import "DetailViewController.h"
@interface ProfileViewController ()
@property (strong,nonatomic) NSArray *userPosts;
@property UIImage *image;

@end

@implementation ProfileViewController

-(void)saveInfoWithImage:(UIImage *)image bio:(NSString *)bio name:(NSString *)name{
    self.user[@"bio"] = bio;
    self.user[@"name"] = name;
    self.user[@"picture_file"] = [Post getPFFileFromImage:image];
    
    self.usernameLabel.text = self.user.username;
    self.nameLabel.text = self.user[@"name"];
    self.bioLabel.text = self.user[@"bio"];
    
    if(self.user[@"picture_file"] != nil){
        self.profilePicView.file = self.user[@"picture_file"];
        [self.profilePicView loadInBackground];
    } else{
        self.profilePicView.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"we did it!");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.user == nil){
        self.user = PFUser.currentUser;
    }
    
    self.usernameLabel.text = self.user.username;
    self.nameLabel.text = self.user[@"name"];
    self.bioLabel.text = self.user[@"bio"];
    
    if(self.user[@"picture_file"] != nil){
        self.profilePicView.file = self.user[@"picture_file"];
        [self.profilePicView loadInBackground];
    } else{
        self.profilePicView.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
    self.profilePicView.layer.cornerRadius = self.profilePicView.frame.size.width/2;
    self.profilePicView.clipsToBounds = TRUE;
    
    UICollectionViewFlowLayout *layout = self.profileCollectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.profileCollectionView.frame.size.width - (postersPerLine-1)*layout.minimumInteritemSpacing)/postersPerLine ;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    //self.postsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.userPosts.count];
    
    
    
    self.profileCollectionView.delegate = self;
    self.profileCollectionView.dataSource = self;
    // Do any additional setup after loading the view.
    [self fetchMyPosts];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    if(self.user[@"picture_file"] != nil){
        self.profilePicView.file = self.user[@"picture_file"];
        [self.profilePicView loadInBackground];
    } else{
        self.profilePicView.image = [UIImage imageNamed:@"image_placeholder.png"];
    }
}



- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    CGSize safeSize = CGSizeMake(1024, 728);
    
    self.image = [self resizeImage:originalImage withSize:safeSize];
    
    self.user[@"picture_file"] = [Post getPFFileFromImage:self.image];
    [self.user saveInBackgroundWithBlock:nil];
    
    
    // Do something with the images (based on your use case)
    //self.profilePicView.image = self.image;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchMyPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:self.user];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * posts, NSError * _Nullable error) {
        if(posts){
            self.userPosts = posts;
        } else{
            NSLog(@"didn't get posts 🙃");
        }
        NSLog(@"%@", @"we fetched user posts");
        [self.profileCollectionView reloadData];
    }];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProfileCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCollectionCell" forIndexPath:indexPath];
    
    Post *post = self.userPosts[indexPath.item];
    
    cell.userPicView.file = post[@"image"];
    [cell.userPicView loadInBackground];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.userPosts.count;
}

- (IBAction)takePictureAction:(UITapGestureRecognizer *)sender {
    NSLog(@"we in touch");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


//- (IBAction)takePicAction:(UITapGestureRecognizer *)sender {
//    NSLog(@"we in touch");
//    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
//    imagePickerVC.delegate = self;
//    imagePickerVC.allowsEditing = YES;
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//    
//    [self presentViewController:imagePickerVC animated:YES completion:nil];
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"profile-detail-segue"]){
        
        ProfileCollectionCell *tappedCell = sender;
        
        NSIndexPath *indexPath = [self.profileCollectionView indexPathForCell:tappedCell];
        Post *thisPost = self.userPosts[indexPath.item];
        UINavigationController *navigationController = [segue destinationViewController];
        DetailViewController *detailViewController = (DetailViewController *)navigationController.topViewController;
        
        
        
        detailViewController.post = thisPost;
        
        //DATE STUFF
    
    } else if([segue.identifier isEqualToString:@"edit-segue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        EditProfileViewController *editProfileViewController = (EditProfileViewController *)navigationController.topViewController;
        editProfileViewController.delegate = self;
    }
}


@end
