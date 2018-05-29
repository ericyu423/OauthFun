//
//  NavigationViewController.m
//  OauthFun
//
//  Created by eric yu on 5/28/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "NavigationViewController.h"


@interface NavigationViewController ()

@property (weak, nonatomic) NSManagedObjectContext *context;

@end

@implementation NavigationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) recevieManageObjectContext:(NSManagedObjectContext *)incomingMangedObjectContext{
    
    self.context = incomingMangedObjectContext;

    id<AFHandlesManageObjectConext> child = (id<AFHandlesManageObjectConext>) self.viewControllers[0];
    [child recevieManageObjectContext:self.context];
}
@end
