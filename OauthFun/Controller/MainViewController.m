//
//  MainViewController.m
//  OauthFun
//
//  Created by eric yu on 5/26/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "MainViewController.h"
#import "WebViewController.h"
#import "MainTableViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *viewUserButtonTitle;
@end

@implementation MainViewController

- (IBAction)viewUserButtonClicked:(UIButton *)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"token"] == nil) {
        WebViewController *webVC = [[WebViewController alloc] init];
        [self presentViewController:webVC animated:true completion:nil];
    }else{
        [self performSegueWithIdentifier:@"MainViewToMainTable" sender:self];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"token"] == nil) {
        [self.viewUserButtonTitle setTitle:@"Please Login" forState: UIControlStateNormal];
    }else{
        [self.viewUserButtonTitle setTitle:@"View User" forState: UIControlStateNormal];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

}



@end
