//
//  Users.h
//  OauthFun
//
//  Created by eric yu on 5/26/18.
//  Copyright © 2018 eric yu. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface User : NSObject

@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *avatarImageUrl;
@property(strong,nonatomic) UIImage *avatarImage;
@property (strong,nonatomic) NSDictionary * badgeCount;

@property (strong,nonatomic) NSString *gold;
@property (strong,nonatomic) NSString *silver;
@property (strong,nonatomic) NSString *bronze;


- (instancetype)initWithName: (NSString *) name gold: (NSString *) gold silver: (NSString *) silver bronze: (NSString *) bronze avatarImageUrl: (NSString *) avatarImageUrl;



+ (NSMutableArray *) parseJson: (NSData *)data;

@end
