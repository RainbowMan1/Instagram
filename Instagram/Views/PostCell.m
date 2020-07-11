//
//  PostCell.m
//  Instagram
//
//  Created by Nikesh Subedi on 7/7/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import "PostCell.h"
#import "Parse/Parse.h"
#import "NSDate+DateTools.h"

@interface PostCell()

@property (nonatomic) BOOL liked;

@end

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    PFRelation *relation =[self.post relationForKey:@"likedBy"];
    PFQuery *likedbyusers = [relation query];
    [likedbyusers findObjectsInBackgroundWithBlock:^(NSArray * _Nullable users, NSError * _Nullable error) {
        if (users.count>0){
            self.post.likeCount = [NSNumber numberWithInteger:users.count];
            for (PFUser * user in users){
                if ([user.objectId isEqual:[PFUser currentUser].objectId]){
                    self.liked=YES;
                }
            }
        }
        [self updateCell];
    }];
    
    [self updateCell];
}

- (IBAction)pressedLike:(id)sender {
    if (self.liked){
        [self postunlike];
    }
    else{
        [self postLike];
    }
    
}

- (void)postLike{
    self.post.likeCount= [NSNumber numberWithInt:[self.post.likeCount intValue] + 1];
    self.liked = YES;
    PFRelation *relation = [self.post relationForKey:@"likedBy"];
    [relation addObject:[PFUser currentUser]];
    [self.post saveInBackground];
    [self updateCell];
}
- (void)postunlike{
    self.post.likeCount= [NSNumber numberWithInt:[self.post.likeCount intValue] - 1];
    self.liked = NO;
    PFRelation *relation = [self.post relationForKey:@"likedBy"];
    [relation removeObject:[PFUser currentUser]];
    [self.post saveInBackground];
    [self updateCell];
}

- (void) updateCell{
    self.usernameLabel.text = self.post.author.username;
    self.postCaption.text = self.post[@"caption"];
    self.postImage.file = self.post[@"image"];
    self.relativeTimeLabel.text = [self.post.createdAt shortTimeAgoSinceNow];
    
    [self.likeButton setTitle:[self.post[@"likeCount"] stringValue] forState:UIControlStateNormal];
    [self.commentButton setTitle:[self.post[@"commentCount"] stringValue] forState:UIControlStateNormal];
    self.liked ? [self.likeButton setImage:[UIImage systemImageNamed:@"heart.fill"] forState:UIControlStateNormal]:[self.likeButton setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateNormal];
    
    [self.postImage loadInBackground:nil progressBlock:nil];
}
@end
