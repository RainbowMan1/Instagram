//
//  HomeViewController.m
//  Instagram
//
//  Created by Nikesh Subedi on 7/7/20.
//  Copyright © 2020 Nikesh Subedi. All rights reserved.
//

#import "HomeViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return [[UITableViewCell alloc]init];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
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


@end
