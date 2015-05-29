//
//  NewsWebViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/5.
//  Copyright (c) 2015年 DavidHu All rights reserved.
//

#import "NewsWebViewController.h"

@interface NewsWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *newsWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation NewsWebViewController

- (void) setNewsWebURL:(NSURL *)newsWebURL
{
    _newsWebURL = newsWebURL;
}

- (void) setNewsWebView:(UIWebView *)newsWebView
{
    _newsWebView = newsWebView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startLoadWeb];
    self.newsWebView.delegate = self;
    [self.spinner startAnimating];
}

- (void)startLoadWeb
{
    NSURLRequest *request=[NSURLRequest requestWithURL:_newsWebURL];
    [_newsWebView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //Check here if still webview is loding the content
    if (webView.isLoading){
        return;
    }
    else{
        [self.spinner stopAnimating];
    }
}

@end
