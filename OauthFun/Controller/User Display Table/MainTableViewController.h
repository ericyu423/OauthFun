//
//  MainTableViewController.h
//  OauthFun
//
//  Created by eric yu on 5/27/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHandlesManageObjectConext.h"

@interface MainTableViewController : UIViewController<AFHandlesManageObjectConext>
@property (strong, nonatomic) NSMutableArray *users;

@end
