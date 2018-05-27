//
//  Users.m
//  OauthFun
//
//  Created by eric yu on 5/26/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithName: (NSString *) name gold: (NSString *) gold silver: (NSString *) silver bronze: (NSString *) bronze avatarImageUrl: (NSString *) avatarImageUrl {
    self = [super init];
    if (self) {
        self.username = name;
        self.avatarImageUrl = avatarImageUrl;
        self.gold = gold;
        self.silver = silver;
        self.bronze = bronze;
    }
    return self;
}

+ (NSMutableArray *) parseJson: (NSData *)data {
    NSError *error = nil;

    NSMutableArray *users = [[NSMutableArray alloc] init];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error != nil) {
        NSLog(@" %@", error.localizedDescription);
    } else {
        NSArray *items = jsonDictionary[@"items"];
        for (NSDictionary *object in items) {
            
            // badge_counts {bronze: 1,silver 2, gold: 3}
            
            NSDictionary *badges = object[@"badge_counts"];
            NSString *name = object[@"display_name"];
            NSString *avatarImageUrl = object[@"profile_image"];
            
            NSString *gold = [NSString stringWithFormat:@"%@",badges[@"gold"]];
            NSString *silver = [NSString stringWithFormat:@"%@",badges[@"silver"]];
            NSString *bronze = [NSString stringWithFormat:@"%@",badges[@"bronze"]];

            User *newUser = [[User alloc] initWithName:name gold:gold silver:silver bronze: bronze avatarImageUrl:avatarImageUrl];
            
            [users addObject:newUser];
        }
    }
    if (users) {
        return users;
    } else {
        NSLog(@"no users found");
        return nil;
    }
}



@end
