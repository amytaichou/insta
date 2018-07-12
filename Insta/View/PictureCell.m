//
//  PictureCell.m
//  Insta
//
//  Created by Amy Liu on 7/9/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import "PictureCell.h"
#import "Post.h"
#import "LoginViewController.h"
#import "ParseUI.h"
#import "Parse.h"

@implementation PictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/*- (void)setPost:(Post *)post {
    self.post = post;
    self.picture.file = post[@"image"];
    [self.picture loadInBackground];
}*/
- (IBAction)didTapLike:(id)sender {
    /*NSLog(@"hello");
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            [self refreshData];
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweet.favorited = YES;
            self.tweet.favoriteCount += 1;
            [self refreshData];
        }
    }];*/
}
- (IBAction)didTapReply:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
