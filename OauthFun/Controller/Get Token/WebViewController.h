//
//  WebViewController.h
//  OauthFun
//
//  Created by eric yu on 5/25/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "NetworkController.h"

@interface WebViewController : UIViewController


@property (strong, nonatomic) NSString *publicKey;
@property (strong, nonatomic) NSString *oAuthDomain;
@property (strong, nonatomic) NSString *clientID;
@property (strong, nonatomic) NSString *oAuthURL;




- (void)instantiatePropertiesWithPublicKey:(NSString *)publicKey oAuthDomain: (NSString *) oAuthDomain clientID: (NSString *) clientID oAuthURL: (NSString *) oAuthURL;

@end
