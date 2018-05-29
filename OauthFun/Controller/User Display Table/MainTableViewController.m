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


@interface MainTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
   
    NSURLSessionDownloadTask * task;
    NSURLSession *session;
    NSCache *imagesCache;
    bool isLoading;
    NSInteger currentPage;
    
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
    
    isLoading = true;
    [self.tableView reloadData]; //display isloading cell
    [self.searchBar resignFirstResponder];
    
    //start at page 1
    
    [[NetworkController networkController] fetchUsersWith:self.searchBar.text currentPage: 1 completionHandler:^(NSError *error, NSMutableArray *users) {
      
        if (error != nil) {
            NSLog(@"%@", error.description);
            self->isLoading = false;
            [self.tableView reloadData];
        } else {
            self->isLoading = false;
            self.users = users;
            [self->imagesCache removeAllObjects];
            [self.tableView reloadData];
        }
        
    }];
}

//MARK: ScrollView Delegate

-(void)scrollViewDidScroll: (UIScrollView*)scrollView {
    //This is not a good way to tell bottom
    
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    
    if (distanceFromBottom < height) {
        currentPage += 1;

        [[NetworkController networkController] fetchUsersWith:self.searchBar.text currentPage: currentPage completionHandler:^(NSError *error, NSMutableArray *users) {
            if (error != nil) {
                NSLog(@"%@", error.description);
                self->isLoading = false;
                [self.tableView reloadData];
            } else {
                //load 30 more
                self->isLoading = false;
                [self.users addObjectsFromArray:users];
                [self->imagesCache removeAllObjects];
                [self.tableView reloadData];
            }
            
        }];
       
    }
 
   
        
    
    
}


//MARK: TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (isLoading) {
            return 1;
    }
    
    return self.users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isLoading) {
        //MARK: add custom tableViewCell to animate if time
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchingCell" forIndexPath:indexPath];
        return cell;
    }

    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    User *user = self.users[indexPath.row];
    
  
    
    
    
    cell.userName.text = user.username;
    cell.gold.text = user.gold;
    cell.silver.text = user.silver;
    cell.bronze.text = user.bronze;
    
    //following code fetches image
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
                    //dispatch to UI thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        MainTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                        cell.avatarImage.image = image;
                        
                        //write to cache
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
