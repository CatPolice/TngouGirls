//
//  RLMenuView.h
//  AudiSuperApp
//
//  Created by runlin on 16/3/16.
//  Copyright © 2016年 www.runlin.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RLTouchMenuView)(NSInteger index,UIButton *button,id item);
typedef NSString*(^RLTitleForMenuItem)(NSInteger index,id item);
typedef NS_OPTIONS(NSUInteger, RLMenuViewStyle) {
    RLMenuViewStyleDefault = 0, //默认底部带条
    RLMenuViewStyleCircle = 1 //红色圈样式
};


@interface RLMenuView : UIView
{
    RLTouchMenuView _RLTouchMenuView;
    NSMutableArray *_buttons;
    RLTitleForMenuItem _RLTitleForMenuItem;
    NSInteger _currentIndex;
}
@property(nonatomic,strong) NSArray *items;
@property (nonatomic,readonly) CGFloat itemWith;

@property (nonatomic,assign) BOOL averageWidth;
@property (nonatomic,assign) CGFloat xSpacing;  //每个item距离

@property (nonatomic,assign) RLMenuViewStyle style;

-(void)setTabClickBlock:(RLTouchMenuView)RLTouchMenuView;
-(void)setTitleForMenuItem:(RLTitleForMenuItem)RLTitleForMenuItem;
-(void)selectIndex:(NSInteger)index;
-(void)reloadData;
@end
