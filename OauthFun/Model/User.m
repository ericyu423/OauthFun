//
//  Users.m
//  OauthFun
//
//  Created by eric yu on 5/26/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithName: (NSString *) name badgeCount: (NSDictionary *) badgeCount avatarImageUrl: (NSString *) avatarImageUrl {
    self = [super init];
    if (self) {
        self.username = name;
        self.badgeCount = badgeCount;
        self.avatarImageUrl = avatarImageUrl;
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
            
            NSDictionary *badgeCount = object[@"badge_counts"];
            NSString *name = object[@"display_name"];
            NSString *avatarImageUrl = object[@"profile_image"];
            
            
//            User *newUser = [[User alloc] initWithName:name badgeCounts:badgeCounts accountID:accountID link:link];
//
            User *newUser = [[User alloc] initWithName:name badgeCount:badgeCount avatarImageUrl:avatarImageUrl];
            
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
