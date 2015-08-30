//
//  LibraryViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/28.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "LibraryViewController.h"
#import "API.h"

@interface LibraryViewController () <UISearchBarDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *librarySearchBar;
@property (weak, nonatomic) IBOutlet UIWebView *libraryWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation LibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.librarySearchBar.keyboardType = UIKeyboardTypeDefault; // 设置弹出键盘的类型
    self.librarySearchBar.placeholder = @"请输入书名"; // 设置提示文字
    self.librarySearchBar.delegate = self; // 设置代理
    self.librarySearchBar.showsCancelButton = YES;
    
    self.libraryWebView.delegate = self;
    
    [self.spinner stopAnimating];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 实现取消按钮的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; // 丢弃第一使用者
}

#pragma mark - 实现键盘上Search按钮的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.spinner startAnimating];
    [searchBar resignFirstResponder];
    
    [self fetchResult];
}

- (void)fetchResult{
    NSString *bookName = self.librarySearchBar.text;
    NSString *bookapi = [NSString stringWithFormat:LibraryAPI, bookName];
    bookapi = [bookapi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:bookapi];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_libraryWebView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.isLoading){
        return;
    }
    else{
        [self.spinner stopAnimating];
    }
}

- (void) setLibraryWebView:(UIWebView *)libraryWebView{
    _libraryWebView = libraryWebView;
}


@end
