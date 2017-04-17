//
//  BaseNavigationController.m
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "BaseNavigationController.h"

#import "BaseNavigationController.h"
#import <objc/runtime.h>

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad

{
    __weak typeof(self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated==YES)
        self.interactivePopGestureRecognizer.enabled = NO;
    
    
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated==YES)
        self.interactivePopGestureRecognizer.enabled = NO;
    
    return  [super popToRootViewControllerAnimated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *lastVC = [self.viewControllers lastObject];
    if ([lastVC isKindOfClass:NSClassFromString(@"BaseViewController")]) {
        SEL selector = NSSelectorFromString(@"backViewControllerAction");
        if ([lastVC respondsToSelector:selector]) {
            //            [lastVC performSelector:selector];
            IMP imp = [lastVC methodForSelector:selector];
            void (*backViewControllerAction)(id, SEL) = (void *)imp;
            backViewControllerAction(lastVC, selector);
        }
    }
    return  [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    return [super popToViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    
    // Enable the gesture again once the new controller is shown
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count<2||self.visibleViewController==[self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}


- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}


@end

