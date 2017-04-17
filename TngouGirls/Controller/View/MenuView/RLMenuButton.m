//
//  RLMenuButton.m
//  AudiSuperService
//
//  Created by runlin on 2017/3/27.
//  Copyright © 2017年 Runlin. All rights reserved.
//

#import "RLMenuButton.h"

@implementation RLMenuButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setStyle:(RLMenuButtonStyle)style{
    _style = style;
    [self applyStyle];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    UIView *view = [self viewWithTag:999];
    if (_style == RLMenuButtonStyleBorder){
        CGFloat h =    [UIScreen mainScreen].scale/2*2;
        view.frame = CGRectMake(0, self.frame.size.height-h, self.frame.size.width, h);
    }else{
        view.frame = CGRectMake(0, (self.frame.size.height-25)/2, self.frame.size.width, 25);
    }
}
- (void)applyStyle{
    [[self viewWithTag:999] removeFromSuperview];

    if (_style == RLMenuButtonStyleBorder) {
        self.clipsToBounds = NO;
        CGFloat h =    [UIScreen mainScreen].scale/2*2;
        UIView *cirlceView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-h, self.frame.size.width, h)];
        cirlceView.tag = 999;
        cirlceView.backgroundColor = [UIColor colorWithRed:187/255.0 green:10/255.0 blue:48/255.0 alpha:1];
        [self insertSubview:cirlceView atIndex:0];
        self.selected = YES;
    }else if (_style == RLMenuButtonStyleCircle) {
        UIView *cirlceView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-25)/2, self.frame.size.width, 25)];
        cirlceView.tag = 999;
        cirlceView.layer.cornerRadius = 25/2;
        cirlceView.layer.masksToBounds = YES;
        cirlceView.backgroundColor = [UIColor colorWithRed:187/255.0 green:10/255.0 blue:48/255.0 alpha:1];
        self.selected = YES;
        [self insertSubview:cirlceView atIndex:0];
    }else{
        [[self viewWithTag:999] removeFromSuperview];
        self.selected = NO;
    }
}

@end
