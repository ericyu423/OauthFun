//
//  StockUser+CoreDataProperties.h
//  OauthFun
//
//  Created by eric yu on 5/29/18.
//  Copyright © 2018 eric yu. All rights reserved.
//
//

#import "StockUser.h"


NS_ASSUME_NONNULL_BEGIN

@interface StockUser (CoreDataProperties)

+ (NSFetchRequest<StockUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *avatarImageUrl;
@property (nullable, nonatomic, copy) NSString *bronze;
@property (nullable, nonatomic, copy) NSString *gold;
@property (nullable, nonatomic, copy) NSString *silver;
@property (nullable, nonatomic, copy) NSString *userID;
@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, retain) Image *image;

@end

NS_ASSUME_NONNULL_END
