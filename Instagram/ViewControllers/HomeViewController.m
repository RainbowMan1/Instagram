//
//  HomeViewController.m
//  Instagram
//
//  Created by Nikesh Subedi on 7/7/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailsViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "PostCell.h"
#import "Post.h"


@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *postArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation HomeViewController

static NSInteger const maxPosts = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self fetchPosts];
    self.refreshControl =[[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    //self.tableView.rowHeight = 300;
}

-(void)fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit=maxPosts;
        // fetch data asynchronously
        [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
            if (posts != nil) {
                self.postArray = posts;
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
                //SLog(@"%@",posts);
            } else {
                NSLog(@"%@", error.localizedDescription);
            }
        }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.postArray[indexPath.row];
    [cell setPost:post];
    //NSLog(@"%@", cell.postCaption.text);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.postArray.count<maxPosts)? self.postArray.count:maxPosts;
}

- (IBAction)logOutPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you Sure?"
                                                                       message:@"Do you want to log out?"
                                                                preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Log Out"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {}];
            
             SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *loginNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            sceneDelegate.window.rootViewController = loginNavigationController;
        }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No"
      style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {}];
    
    [yesAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
        
        [alert addAction:cancelAction];
    [alert addAction:yesAction];
        [self presentViewController:alert animated:YES completion:^{}];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]){
    PostCell *selectedcell = (PostCell*) sender;
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.post = selectedcell.post;
        detailsViewController.startcomment = NO;
    }
    else if ([segue.identifier isEqualToString:@"comment"]){
        UIButton *button = (UIButton*) sender;
        PostCell *selectedcell = button.superview.superview;
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = selectedcell.post;
        detailsViewController.startcomment = YES;
    }
    // Pass the selected object to the new view controller.
}

@end
