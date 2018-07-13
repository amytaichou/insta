//
//  DetailedViewController.m
//  Insta
//
//  Created by Amy Liu on 7/9/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "DetailedViewController.h"
#import "Post.h"
#import "ParseUI/ParseUI.h"


@interface DetailedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profile;
@property (weak, nonatomic) IBOutlet UILabel *username;

@end

@implementation DetailedViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadPost];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPost {
    
    //self.username.text = self.tweet.user.name;
    self.caption.text = self.post.caption;
    self.picture.file = self.post[@"image"];
    self.username.text = self.post.author.username;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-ddTHH:mm:ss.SSSZ"];
    self.timestamp.text = [dateFormat stringFromDate:self.post.createdAt];
    
    [self.picture loadInBackground];

    
    //self.timestamp.text = self.tweet.createdAtString;
    //self.handle.text = self.tweet.user.screenName;
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
