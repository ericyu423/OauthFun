//
//  NetworkController.m
//  OauthFun
//
//  Created by eric yu on 5/25/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "NetworkController.h"
#import "User.h"

@implementation NetworkController

// thread-safe way to create an instance of a class
+ (id) networkController {
    static NetworkController *networkController = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        networkController = [[self alloc] init];
    });
    return networkController;
}


- (void) fetchUsersWith: (NSString *)name completionHandler: (void (^)(NSError *error, NSMutableArray *users))success {
    
    //name encoding
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]\" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedName = [name stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&inname=%@&site=stackoverflow", encodedName];
    if (encodedName == nil)
    {   //page 1
        urlString = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/users?page=%d&site=stackoverflow",1];
    }
    //serach for user without name
    /*
    NSString *urlString = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/users?page=1&order=desc&max=999&sort=reputation&site=stackoverflow"];*/
    
    NSString *acess_token = [NSString stringWithFormat: @"&access_token=%@", token];
    NSString *key = [NSString stringWithFormat: @"&key=%@", kPublicKey];
    NSString *token_and_key = [acess_token stringByAppendingString:key];
    urlString = [urlString stringByAppendingString:token_and_key];
    NSURL *url = [[NSURL alloc] initWithString: urlString];
    
    //NSLOG
    NSLog(@"oauth key: %@", key);
    NSLog(@"access token: %@", token);
    NSLog(@"parm: %@", token_and_key);
    NSLog(@"url: %@", url);

    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.urlSession = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != 0) {
            NSLog(@"%@", error.description);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if (httpResponse.statusCode == 200) {
                
                NSLog(@"fetch successful");
                NSMutableArray *users = [User parseJson:data];
       
                dispatch_async(dispatch_get_main_queue(), ^{
                   success(nil, users);
                });
  
            } else {
      
                NSLog(@"fetch was unsuccessful. code: %lu", httpResponse.statusCode);
            }
        }
    }];
    [dataTask resume];
}


@end

