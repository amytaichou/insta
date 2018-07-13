//
//  FeedViewController.m
//  Insta
//
//  Created by Amy Liu on 7/9/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "FeedViewController.h"
#import "Parse.h"
#import "PictureCell.h"
#import "Post.h"
#import "ComposeViewController.h"
#import "DetailedViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"

// ORGANIZE CODE / rename tablecell

// placing in picturecell vs placing in feed controller (outlets)
// difference between show, present modally, etc.

@interface FeedViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<Post *> *pictureArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end

@implementation FeedViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 550;
    // self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    /* [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"PictureCell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:HeaderViewIdentifier];
    */
    [self fetchPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)fetchPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    
    [postQuery includeKeys:@[@"author", @"createdAt"]];
    [postQuery orderByDescending:@"createdAt"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.pictureArray = posts;
            [self.tableView reloadData];
        }
        else {
            // handle error
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Actions

- (IBAction)didTapCompose:(id)sender {
    [self performSegueWithIdentifier:@"ComposeViewSegue" sender:nil];
}

- (IBAction)didTapLogOut:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [appDelegate logout];
     //[self dismissViewControllerAnimated:TRUE completion:nil];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pictureArray.count;
} // how many cells do ya got buddy

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell" forIndexPath:indexPath];
    
    Post *post = self.pictureArray[indexPath.row];
    cell.post = post;
     //[cell.imageView setIma [NSURL URLWithString: post.image.url];
    cell.picture.file = post[@"image"];
    [cell.picture loadInBackground];
    cell.username.text = post.username;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-ddTHH:mm:ss.SSSZ"];
    cell.timestamp.text = [dateFormat stringFromDate:post.createdAt];
    
    cell.likeCount.text = [NSString stringWithFormat:@"%i", post.likeCount];

    cell.caption.text = post.caption;
    
    
    return cell;
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    [self fetchPosts];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Handle scroll behavior here
    if(!self.isMoreDataLoading){
        self.isMoreDataLoading = true;
        
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
    }
}
}
        
-(void)loadMoreData{
    PFQuery *morePosts;
    [morePosts includeKeys:@[@"author", @"createdAt"]];
    [morePosts orderByDescending:@"createdAt"];
    morePosts.skip = [self.pictureArray count];
    morePosts.limit = 20;
    
    // fetch data asynchronously
    [morePosts findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.pictureArray = posts;
            [self.tableView reloadData];
        }
        else {
            // handle error
        }
        [self.refreshControl endRefreshing];
    }];
}

/* #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SegueToComposeViewController"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"SegueToDetailedViewController"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        
        Post *post = self.pictureArray[indexPath.row];
        
        DetailedViewController *detailedPicController = [segue destinationViewController];
        
        detailedPicController.post = post;
    }
} */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    
        Post *post = self.pictureArray[indexPath.row];
        
        DetailedViewController *detailedViewController = [segue destinationViewController];
    
        detailedViewController.post = post;
    }
}


@end
