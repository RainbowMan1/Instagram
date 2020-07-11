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

+ (void) postComment: ( NSString * _Nullable )text forPost:(Post*) post withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    
    Comment *newComment = [Comment new];
    newComment.text = text;
    newComment.author = [PFUser currentUser];
    [newComment setValue:post forKeyPath:@"post"];
    [newComment saveInBackgroundWithBlock:completion];
    
}
@end
