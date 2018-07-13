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

#pragma mark - Actions

- (IBAction)didTapLike:(id)sender {
    NSLog(@"hello");
    if (self.post.favorited) {
        NSLog(@"Already liked");
    } else {
        self.post.favorited = YES;
        int newLikes = [self.post.likeCount intValue] + 1;
        self.post.likeCount = [NSNumber numberWithInt:newLikes];
        self.likeCount.text = [self.post.likeCount stringValue];
        [self refreshData];
        NSLog(@"Successfully favorited the following Tweet: %@", self.post.caption);
}
}

/* - (IBAction)didTapReply:(id)sender {
} */

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}

#pragma mark - View Life Cycle

- (void) refreshData {
    //[NSString stringWithFormat:@"%d", self.retweetCount.text];
    if(self.post.favorited){
        self.likeButton.selected = YES;
        // self.post.likeCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    }
}

- (void)setPost:(Post *)post {
    _post = post;
    
    self.picture.file = self.post.image;
    self.username.text = self.post.username;
    self.caption.text = self.post.caption;
    self.profileImage.file = self.post.author.image;
    self.likeCount.text = [self.post.likeCount stringValue];
    
    
    [self.profileImage loadInBackground];
    [self.picture loadInBackground];
}


@end
