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

@interface MainTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
   
    NSURLSessionDownloadTask * task;
    NSURLSession *session;
    NSCache *imagesCache;
    
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self intializeImageHelpers];
   
    
}

- (void) intializeImageHelpers {
    //image download helper
    session = [NSURLSession sharedSession];
    task = [[NSURLSessionDownloadTask alloc] init];
    imagesCache = [[NSCache alloc] init];
    
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
            [self->imagesCache removeAllObjects];
           [self.tableView reloadData];
     

         }
                           
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
    
    if ([imagesCache objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]] != nil) {
        cell.avatarImage.image = [imagesCache objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        
    }else {
 
    NSURL *nsurl = [NSURL URLWithString:user.avatarImageUrl];
    task = [session downloadTaskWithURL:nsurl completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                if (error != 0) {
                    NSLog(@"%@", error.description);
                } else {
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
                    if (httpResponse.statusCode == 200) {
                        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:nsurl]];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                        
                            
                            MainTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                            cell.avatarImage.image = image;
                            
                          
                            [self->imagesCache setObject:image forKey: [NSString stringWithFormat:@"%ld", (long)indexPath.row]];
                        
                        });

                        
                    }
        
                }
    }];
    [task resume];
    }


    return cell;
}
@end
