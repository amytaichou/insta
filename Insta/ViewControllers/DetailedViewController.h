//
//  DetailedViewController.h
//  Insta
//
//  Created by Amy Liu on 7/9/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "Post.h"

@interface DetailedViewController : UIViewController

@property (nonatomic, strong) Post *post;

@property (weak, nonatomic) IBOutlet PFImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;

-(void)loadPost;

@end
