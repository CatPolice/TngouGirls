//
//  TGWKWebView.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface TGWKWebView : WKWebView<UIScrollViewDelegate>
@property (strong, nonatomic)  UIProgressView *progressView;
@end
