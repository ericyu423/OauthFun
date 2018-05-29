//
//  NetworkController.h
//  OauthFun
//
//  Created by eric yu on 5/25/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackAppPassport.h"

@interface NetworkController : NSObject

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSString *token;
//current page tracks current loading page location
@property NSInteger currentPage;



- (void) fetchUsersWith: (NSString *)name currentPage: (NSInteger) currentPage completionHandler: (void (^)(NSError *error, NSMutableArray *names))success;

+ (id) networkController;

@end
