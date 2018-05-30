//
//  Image+CoreDataProperties.m
//  OauthFun
//
//  Created by eric yu on 5/29/18.
//  Copyright © 2018 eric yu. All rights reserved.
//
//

#import "Image+CoreDataProperties.h"

@implementation Image (CoreDataProperties)

+ (NSFetchRequest<Image *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Image"];
}

@dynamic stockUser;

@end
