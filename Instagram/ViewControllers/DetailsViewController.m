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
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self fetchComments];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.refreshControl addTarget:self action:@selector(fetchComments) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = self.refreshControl;
    [self.tableView addSubview:self.refreshControl];
}


- (IBAction)onTap:(id)sender {
    DetailCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.commentText endEditing:YES];
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
                [self.refreshControl endRefreshing];
            }
        }];
}



- (IBAction)postComment:(id)sender {
    DetailCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [Comment postComment:cell.commentText.text forPost:self.post withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded){
            self.post.commentCount= [NSNumber numberWithInt:[self.post.commentCount intValue] + 1];
            [self.post saveInBackground];
            [self fetchComments];
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
        if (self.startcomment) {
          [detailcell.commentText becomeFirstResponder];
        }
        detailcell.commentText.layer.borderWidth =1.0f;
        detailcell.commentText.layer.cornerRadius = 12;
        detailcell.commentText.clearsOnInsertion=YES;
        if ([detailcell.commentButton.titleLabel.text isEqualToString:@"0"]){
            [detailcell.commentHeader setHidden:YES];
        }
        return detailcell;
    }
    else{
        CommentCell *commentcell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        Comment *comment =self.commentsArray[indexPath.row -1];
        commentcell.commentLabel.text = comment[@"text"];
        commentcell.usernameLabel.text = comment.author.username;
        (indexPath.row%2==0)?[commentcell.commentBackground setBackgroundColor:[UIColor darkGrayColor]]:[commentcell.commentBackground setBackgroundColor:[UIColor lightGrayColor]];
        
        return commentcell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsArray.count+1;
}

@end
