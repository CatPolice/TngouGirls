//
//  RLMenuButton.h
//  AudiSuperService
//
//  Created by runlin on 2017/3/27.
//  Copyright © 2017年 Runlin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, RLMenuButtonStyle) {
    RLMenuButtonStyleNone = 1 << 0,
    RLMenuButtonStyleBorder = 1 << 1,
    RLMenuButtonStyleCircle = 1 << 2,
};
@interface RLMenuButton : UIButton
@property (nonatomic,assign)RLMenuButtonStyle style;
@end
