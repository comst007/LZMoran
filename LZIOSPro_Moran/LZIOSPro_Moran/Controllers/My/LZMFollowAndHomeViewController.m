//
//  LZMFollowAndHomeViewController.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMFollowAndHomeViewController.h"

@interface LZMFollowAndHomeViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation LZMFollowAndHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadHomePage];
}

- (void)loadHomePage{
    
    NSString *url = @"http://www.baidu.com";
    NSURL *URl = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URl];
    
    [self.webview loadRequest:request];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.indicator stopAnimating];
}

@end
