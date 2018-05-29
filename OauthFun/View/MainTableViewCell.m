//
//  MainTableViewCell.m
//  OauthFun
//
//  Created by eric yu on 5/26/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    //make image Avatar a circular
    [self.avatarImage.layer setCornerRadius:self.avatarImage.frame.size.height/2.0];
    self.avatarImage.clipsToBounds = true;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
