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


@interface WebViewController () <WKNavigationDelegate>{
    WKWebView *webView;
}
@end

@implementation WebViewController
-(void)stopSpinner {
     [[self.view viewWithTag:1] stopAnimating];
}

-(void)animateSpinner {
    
    //MARK: Make spinner bigger
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    spinner.center = CGPointMake(self.view.center.x,self.view.center.y);
    spinner.tag = 1;
   // [self webView.view  addSubview:spinner];
    [webView addSubview:spinner];
    [spinner startAnimating];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];

    webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    [self animateSpinner];
    webView.navigationDelegate = self;

    NSString *loginURL = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",kOAuthURL,kClientID,kOAuthDomain];

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:loginURL]]];

}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self stopSpinner];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
     [self stopSpinner];
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
@end

