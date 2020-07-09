//
//  PostCell.m
//  Instagram
//
//  Created by Nikesh Subedi on 7/7/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import "PostCell.h"

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
    self.postCaption.text = post[@"caption"];
    self.postImage.file = post[@"image"];
    [self.postImage loadInBackground:nil progressBlock:nil];
}

@end
