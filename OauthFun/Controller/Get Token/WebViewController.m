//
//  WebViewController.m
//  OauthFun
//
//  Created by eric yu on 5/25/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

#import "WebViewController.h"
#import "StackAppPassport.h"
#import <SafariServices/SafariServices.h>


@interface WebViewController () <WKNavigationDelegate>
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    
 
    
    webView.navigationDelegate= self;

    
//    NSString *const kPublicKey   = @"ph9GJgpB2ZIc0lYwqBgSug((";
//    NSString *const kOAuthDomain = @"https://stackexchange.com/oauth/login_success";
//    NSString *const kClientID    = @"12519";
//    NSString *const kOAuthURL    = @"https://stackoverflow.com/oauth";
    
    //Refactor code
//    NSString *baseURL = @"https://stackexchange.com/oauth";///dialog";
//    NSString *clientID = @"12519";
//    NSString *redirectURI = @"https://stackexchange.com/oauth/login_success";
    NSString *loginURL = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",kOAuthURL,kClientID,kOAuthDomain];

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:loginURL]]];
    
  
 
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if ([navigationAction.request.URL.path isEqualToString:@"/oauth/login_success"]) {
        NSString *returnUrlString = navigationAction.request.URL.fragment;
        NSArray *components = [returnUrlString componentsSeparatedByString:@"&"];
        //access_token=JEpKeXx7sc*2ro8jUWpoEw))
        NSString *accessTokenComponent = components.firstObject;
        NSString *token = [accessTokenComponent componentsSeparatedByString:@"="].lastObject;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:token forKey:@"token"];
        [defaults synchronize];
        [self dismissViewControllerAnimated:true completion:nil];
    
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

/*
//only get called in 403 error fix this if I have time
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    if ([navigationResponse.response isKindOfClass:[NSHTTPURLResponse class]]) {
        
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)navigationResponse.response;
  
        if (response.statusCode == 403) {
          //need to use SFSafariViewController
          //to get rid of google sign in 403 error
         NSURL *url = [NSURL URLWithString:loginURL];
         SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
         [self showViewController:safariVC sender:nil];
                }
        
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}*/

- (void)instantiatePropertiesWithPublicKey:(NSString *)publicKey oAuthDomain: (NSString *) oAuthDomain clientID: (NSString *) clientID oAuthURL: (NSString *) oAuthURL {
    self.publicKey = publicKey;
    self.oAuthDomain = oAuthDomain;
    self.clientID = clientID;
    self.oAuthURL = oAuthURL;
}

@end

