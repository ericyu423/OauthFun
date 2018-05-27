//
//  Users.h
//  OauthFun
//
//  Created by eric yu on 5/26/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject

@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *avatarImageUrl;
@property (strong,nonatomic) NSDictionary * badgeCount;


- (instancetype)initWithName: (NSString *) name badgeCount: (NSDictionary *) badgeCount avatarImageUrl: (NSString *) avatarImageUrl;



+ (NSMutableArray *) parseJson: (NSData *)data;

@end
