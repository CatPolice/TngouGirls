//
//  TGWKWebView.m
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "TGWKWebView.h"

@implementation TGWKWebView
- (void)drawRect:(CGRect)rect {
    _progressView = [[UIProgressView alloc] init];
    _progressView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 3);
    
    _progressView.tintColor = [UIColor colorWithRed:21.0 / 255.0 green:126.0 / 255.0 blue:251.0 / 255.0 alpha:1.0];
    _progressView.trackTintColor = [UIColor whiteColor];
    [self addSubview:_progressView];
    self.scrollView.delegate = self;
    //添加观察者
    [self addObserver:self forKeyPath:@"estimatedProgress"options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (object == self) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.estimatedProgress animated:YES];
            
            if(self.estimatedProgress >=1.0f) {
                
                [UIView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    if (scrollView.contentOffset.y/scrollView.contentSize.height>0) {
        [self.progressView setAlpha:1.0f];
        self.progressView.progress = scrollView.contentOffset.y/(scrollView.contentSize.height-scrollView.bounds.size.height);
    }else{
        [self.progressView setAlpha:0.0f];
    }
}
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
