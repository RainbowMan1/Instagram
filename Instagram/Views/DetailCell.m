//
//  DetailCell.m
//  Instagram
//
//  Created by Nikesh Subedi on 7/9/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import "DetailCell.h"
#import "Comment.h"
#import "Parse/Parse.h"

@implementation DetailCell

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
    self.postCaption.text = post[@"caption"];
    NSLog(@"%@",post[@"caption"]);
    NSLog(@"%@",self.postCaption.text);
    self.postImage.file = post[@"image"];
    [self.postImage loadInBackground:nil progressBlock:nil];
    self.commentText.layer.borderWidth =1.0f;
    self.commentText.layer.cornerRadius = 18;
}
- (IBAction)postComment:(id)sender {
    [Comment postComment:self.commentText.text forPost:self.post];
}
@end
