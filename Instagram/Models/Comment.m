//
//  Comment.m
//  Instagram
//
//  Created by Nikesh Subedi on 7/9/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import "Comment.h"
@implementation Comment

@dynamic author;
@dynamic text;
@dynamic post;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}
+ (void) postComment: ( NSString * _Nullable )text forPost:(Post*) post {
    
    Comment *newComment = [Comment new];
    newComment.text = text;
    newComment.author = [PFUser currentUser];
    [newComment setValue:post forKeyPath:@"post"];
    [newComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded){
            post.commentCount= [NSNumber numberWithInt:[post.commentCount intValue] + 1];
            [post saveInBackground];
        }
    }];
    
}
@end
