//
//  DetailedViewController.m
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "DetailedViewController.h"
#import "TGWKWebView.h"

@interface DetailedViewController ()<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>
@property (strong, nonatomic)  TGWKWebView *myWebView;
@property (weak, nonatomic) IBOutlet UIView *wkWebViewSuperView;
@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象Native，
    // 声明WKScriptMessageHandler 协议
    [config.userContentController addScriptMessageHandler:self name:@"XXXXXXX"];
    
    self.myWebView = [[TGWKWebView alloc] initWithFrame:self.wkWebViewSuperView.bounds configuration:config];
    self.myWebView.UIDelegate = self;
    self.myWebView.navigationDelegate = self;
    [self.wkWebViewSuperView addSubview:self.myWebView];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [self.myWebView loadRequest:request];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.myWebView setFrame:self.wkWebViewSuperView.bounds];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"XXXXXXX"] && [[message.body description] isEqualToString:@"xx"]) {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
