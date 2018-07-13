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

@interface FeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) id<FeedViewControllerDelegate> delegate;
@property (assign, nonatomic) BOOL isMoreDataLoading;

- (void)fetchPosts;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)loadMoreData;

@end
