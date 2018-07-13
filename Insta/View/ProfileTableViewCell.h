//
//  ProfileTableViewCell.h
//  Insta
//
//  Created by Amy Liu on 7/12/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface ProfileTableViewCell : UITableViewCell <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *profile;
@property (weak, nonatomic) IBOutlet UILabel *username;

@property (strong, nonatomic) Post *post;

@end
