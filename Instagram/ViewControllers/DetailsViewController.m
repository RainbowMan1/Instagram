//
//  DetailsViewController.m
//  Instagram
//
//  Created by Nikesh Subedi on 7/8/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import "DetailsViewController.h"
#import "Comment.h"
#import "DetailCell.h"
#import "CommentCell.h"

@interface DetailsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *commentsArray;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self fetchComments];
    // Do any additional setup after loading the view.
}

-(void)fetchComments {
        PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
        [query orderByDescending:@"createdAt"];
        [query includeKey:@"author"];
        [query whereKey:@"post" equalTo:self.post];
        [query findObjectsInBackgroundWithBlock:^(NSArray* _Nullable comments, NSError * _Nullable error) {
            if (comments) {
                self.commentsArray = comments;
                NSLog(@"%@", self.commentsArray);
                [self.tableView reloadData];
            }
        }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        DetailCell *detailcell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
        detailcell.post = self.post;
        if (self.startcomment) [detailcell.commentText becomeFirstResponder];
        return detailcell;
    }
    else{
        CommentCell *commentcell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        Comment *comment =self.commentsArray[indexPath.row -1];
        commentcell.commentLabel.text = comment[@"text"];
        return commentcell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsArray.count+1;
}


@end
