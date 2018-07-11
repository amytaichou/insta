//
//  FeedViewController.h
//  Insta
//
//  Created by Amy Liu on 7/9/18.
//  Copyright © 2018 Amy Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@protocol FeedViewControllerDelegate<NSObject>



@end

@interface FeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<FeedViewControllerDelegate> delegate;

- (void)fetchPosts;

@end
