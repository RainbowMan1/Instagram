//
//  Comment.h
//  Instagram
//
//  Created by Nikesh Subedi on 7/9/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#ifndef Comment_h
#define Comment_h
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "Post.h"
@interface Comment : PFObject<PFSubclassing>
@property (nonatomic, strong) PFUser * _Nullable author;
@property (nonatomic, strong) NSString * _Nullable text;
@property (nonatomic, strong) Post * _Nullable post;

+ (void) postComment: ( NSString * _Nullable )text forPost:(Post*_Nullable) post;

@end
#endif /* Comment_h */
