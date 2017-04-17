//
//  BaseViewController.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAINSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAINSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_SCALE [UIScreen mainScreen].bounds.size.width/375

@interface BaseViewController : UIViewController

-(IBAction)backButtonTouched:(UIButton*)sender;

@end
