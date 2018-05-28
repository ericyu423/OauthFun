//
//  MainTableViewCell.h
//  OauthFun
//
//  Created by eric yu on 5/26/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *gold;
@property (weak, nonatomic) IBOutlet UILabel *silver;
@property (weak, nonatomic) IBOutlet UILabel *bronze;

@end
