//
//  Image+CoreDataProperties.h
//  OauthFun
//
//  Created by eric yu on 5/29/18.
//  Copyright © 2018 eric yu. All rights reserved.
//
//

#import "Image.h"


NS_ASSUME_NONNULL_BEGIN

@interface Image (CoreDataProperties)

+ (NSFetchRequest<Image *> *)fetchRequest;

@property (nullable, nonatomic, retain) StockUser *stockUser;

@end

NS_ASSUME_NONNULL_END
