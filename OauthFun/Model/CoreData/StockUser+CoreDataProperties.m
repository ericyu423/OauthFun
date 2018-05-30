//
//  StockUser+CoreDataProperties.m
//  OauthFun
//
//  Created by eric yu on 5/29/18.
//  Copyright © 2018 eric yu. All rights reserved.
//
//

#import "StockUser+CoreDataProperties.h"

@implementation StockUser (CoreDataProperties)

+ (NSFetchRequest<StockUser *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"StockUser"];
}

@dynamic avatarImageUrl;
@dynamic bronze;
@dynamic gold;
@dynamic silver;
@dynamic userID;
@dynamic username;
@dynamic image;

@end
