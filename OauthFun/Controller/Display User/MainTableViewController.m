//
//  MainTableViewController.m
//  OauthFun
//
//  Created by eric yu on 5/27/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableViewCell.h"
#import "NetworkController.h"
#import "User.h"

@interface MainTableViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: SerachBar Delegates

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [[NetworkController networkController] fetchUsersWith:self.searchBar.text completionHandler:^(NSError *error, NSMutableArray *users) {
        //UI Thread
        
        if (error != nil) {
            NSLog(@"%@", error.description);
        } else {
            self.users = users;
           // [self.searchBar resignFirstResponder];
            
           [self.tableView reloadData];
          
            
        }
        
        /*
        dispatch_async(dispatch_get_main_queue(), ^{
            //display new data on main thread.
        }*/

                           
                           
    }];
}

//MARK: TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    User *user = self.users[indexPath.row];
    
    //refactor the following code
    cell.userName.text = user.username;
    //cell.imageUrlTempJustToSee.text = user.avatarImageUrl;
  
    cell.gold.text = user.gold;
    cell.silver.text = user.silver;
    cell.bronze.text = user.bronze;

    return cell;
}
@end
