//
//  PostCell.h
//  Instagram
//
//  Created by Nikesh Subedi on 7/7/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
