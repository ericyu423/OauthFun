//
//  StockUser+CoreDataProperties.m
//  
//
//  Created by eric yu on 5/28/18.
//
//

#import "StockUser+CoreDataProperties.h"

@implementation StockUser (CoreDataProperties)

+ (NSFetchRequest<StockUser *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"StockUser"];
}

@dynamic username;
@dynamic avatarImageUrl;
@dynamic avatarImage;
@dynamic gold;
@dynamic silver;
@dynamic bronze;
@dynamic userID;

@end
