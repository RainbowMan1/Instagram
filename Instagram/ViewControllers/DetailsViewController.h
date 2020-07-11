//
//  DetailsViewController.h
//  Instagram
//
//  Created by Nikesh Subedi on 7/8/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Post *post;
@property (nonatomic) BOOL startcomment;

@end

NS_ASSUME_NONNULL_END
