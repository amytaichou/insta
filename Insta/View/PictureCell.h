//
//  PictureCell.h
//  Insta
//
//  Created by Amy Liu on 7/9/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "ParseUI.h"
#import "Parse.h"

@interface PictureCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (strong, nonatomic) Post *post;

@end
