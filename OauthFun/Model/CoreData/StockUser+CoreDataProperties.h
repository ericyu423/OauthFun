//
//  StockUser+CoreDataProperties.h
//  
//
//  Created by eric yu on 5/28/18.
//
//

#import "StockUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StockUser (CoreDataProperties)

+ (NSFetchRequest<StockUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *avatarImageUrl;
@property (nullable, nonatomic, copy) NSDate *avatarImage;
@property (nullable, nonatomic, copy) NSString *gold;
@property (nullable, nonatomic, copy) NSString *silver;
@property (nullable, nonatomic, copy) NSString *bronze;
@property (nullable, nonatomic, copy) NSString *userID;

@end

NS_ASSUME_NONNULL_END
