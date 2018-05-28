//
//  MainTableViewController.h
//  OauthFun
//
//  Created by eric yu on 5/27/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *users;
@property (weak, nonatomic) NSManagedObjectContext *context;
@end
