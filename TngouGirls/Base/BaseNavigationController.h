//
//  BaseNavigationController.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;

@end
