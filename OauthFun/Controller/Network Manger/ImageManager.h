//
//  ImageManager.h
//  OauthFun
//
//  Created by eric yu on 5/27/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageManager : NSObject

+(id)sharedService;

-(void)fetchProfileImages:(NSArray *)urls completionHandler:(void (^)(NSArray* images))completionHandler;

-(UIImage *)getAvatrFrom:(NSString *)urlString;

@end



