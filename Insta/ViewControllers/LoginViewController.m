//
//  LoginViewController.m
//  Insta
//
//  Created by Amy Liu on 7/9/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "Parse.h"
#import "FeedViewController.h"
#import "Post.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginUser {
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        if ([segue.identifier isEqualToString:@"SegueToSignUpViewController"]) {
            UINavigationController *navigationController = [segue destinationViewController];
            SignUpViewController *signUpController = (SignUpViewController*)navigationController.topViewController;
            signUpController.delegate = self;
        } else if ([segue.identifier isEqualToString:@"SegueToFeedViewController"]) {
            UINavigationController *navigationController = [segue destinationViewController];
            FeedViewController *feedController = (FeedViewController*)navigationController.topViewController;
            feedController.delegate = self;
    }
}

@end
