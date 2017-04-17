//
//  RLMenuView.m
//  AudiSuperApp
//
//  Created by runlin on 16/3/16.
//  Copyright © 2016年 www.runlin.cn. All rights reserved.
//

#import "RLMenuView.h"
#import "RLMenuButton.h"
#define LINE_HEIGHT [UIScreen mainScreen].scale/2
@interface RLMenuView()
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) UIView *border;
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation RLMenuView

-(void)setItems:(NSArray *)items{
    _items = items;
    [self reloadData];
}

-(void)reloadData{
    NSArray *subViews = self.scrollView.subviews;
    if([subViews count] != 0)
    {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [_buttons removeAllObjects];
    

    [self.items enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
        
        RLMenuButton *buttonItem = [RLMenuButton buttonWithType:UIButtonTypeCustom];
        //        buttonItem.typeName = titleString;
        if (_RLTitleForMenuItem) {
            //            buttonItem.typeName = _titleForTabItem(idx,item);
            [buttonItem setTitle:_RLTitleForMenuItem(idx,item) forState:UIControlStateNormal];
            
        }else{
            [buttonItem setTitle:[item description] forState:UIControlStateNormal];

        }
        buttonItem.titleLabel.adjustsFontSizeToFitWidth = YES;
        if (self.style == RLMenuViewStyleDefault) {
            [buttonItem setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];

            [buttonItem setTitleColor:[UIColor colorWithRed:187/255.0  green:10/255.0  blue:48/255.0  alpha:1] forState:UIControlStateSelected];
        }else{
            [buttonItem setTitleColor:[UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1] forState:UIControlStateNormal];
            
            [buttonItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        }
      
        buttonItem.titleLabel.textAlignment = NSTextAlignmentCenter;
        buttonItem.titleLabel.font = [UIFont systemFontOfSize:14.0];
        buttonItem.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        buttonItem.titleLabel.numberOfLines = 0;
        
        buttonItem.backgroundColor = [UIColor clearColor];
        buttonItem.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
                buttonItem.tag = 20000 + idx;
        [buttonItem addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchDown];
        [self.scrollView addSubview:buttonItem];
        if (!_buttons) {
            _buttons = [NSMutableArray array];
        }
        [_buttons addObject:buttonItem];
        
    }];

    [self addSubview:self.border];
    [self addSubview:self.scrollView];

    [self reLayout];
}
-(UIView *)border{
    if (!_border) {
        _border = [[UIView alloc] init];
        _border.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.000];
    }
    return _border;
}
-(void)reLayout{
    self.border.frame = CGRectMake(0, self.frame.size.height - LINE_HEIGHT, self.frame.size.width, LINE_HEIGHT);
    self.scrollView.frame = self.bounds;
    _border.frame = CGRectMake(0, self.frame.size.height - LINE_HEIGHT, self.frame.size.width, LINE_HEIGHT);
    
    __block float contentSize = 0;
    
    if (_averageWidth) {
        _itemWith = (self.frame.size.width - _xSpacing*(self.items.count +1))/self.items.count;
    }else{
        _itemWith  = 80;
    }
    [_buttons enumerateObjectsUsingBlock:^(RLMenuButton *buttonItem, NSUInteger idx, BOOL * _Nonnull stop) {
//        self.scrollView.contentSize = CGSizeMake(contentSize, 0);
        CGFloat itemWith;
        CGFloat edge = buttonItem.titleEdgeInsets.left + buttonItem.titleEdgeInsets.right;
        if (_averageWidth) {
            itemWith =_itemWith;
            buttonItem.frame = CGRectMake(contentSize +  _xSpacing,0 ,itemWith,  self.frame.size.height);
            contentSize += itemWith + _xSpacing;
        }else{
            itemWith  =  [self widthWithString:buttonItem.currentTitle fontSize:14 height:14];
            buttonItem.frame = CGRectMake(contentSize +  _xSpacing + edge,0 ,itemWith + edge,  self.frame.size.height);
            contentSize += itemWith + _xSpacing + edge;

        }
        if (buttonItem.tag == _currentIndex) {
            [self appleStyle:buttonItem];
        }
        self.scrollView.contentSize = CGSizeMake(contentSize, 0);
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self reLayout];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.directionalLockEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.canCancelContentTouches = YES;
    }
    return _scrollView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview;
{
    if (newSuperview)
    {
        self.clipsToBounds = YES;
    }
}
- (void)setStyle:(RLMenuViewStyle)style{
    _style = style;
    [self reloadData];
}
-(void)setAverageWidth:(BOOL)averageWidth{
    _averageWidth = averageWidth;
    [self reloadData];
}
-(void)setTabClickBlock:(RLTouchMenuView)RLTouchMenuView{
    _RLTouchMenuView = [RLTouchMenuView copy];
    [self reloadData];

}
-(void)setTitleForMenuItem:(RLTitleForMenuItem)RLTitleForMenuItem{
    _RLTitleForMenuItem = [RLTitleForMenuItem copy];
    [self reloadData];

}
-(void)setItemWith:(CGFloat)itemWith{
    _itemWith = itemWith;
    [self reloadData];

}
-(void)setXSpacing:(CGFloat)xSpacing{
    _xSpacing = xSpacing;
    [self reloadData];
}
-(void)selectIndex:(NSInteger)index{
    [self touchAction:_buttons[index]];
}

- (void)touchAction:(RLMenuButton*)sender{
    for (RLMenuButton *button in _buttons) {
        if ([button isKindOfClass:[UIButton class]]) {
            if (button == sender) {
                _currentIndex = sender.tag;
                if (_RLTouchMenuView) {
                    _RLTouchMenuView(sender.tag-20000,sender,[self.items objectAtIndex:sender.tag-20000]);
                }
            }else
            {
                button.titleLabel.font = [UIFont systemFontOfSize:14.0];
                
            }
        }
        
    }
    [self appleStyle:sender];
}
-(void)appleStyle:(RLMenuButton*)sender{
    for (RLMenuButton *button in _buttons) {
        if ([sender isKindOfClass:[UIButton class]]) {
            if (sender == button) {
                if (self.style == RLMenuViewStyleDefault) {
                    button.style = RLMenuButtonStyleBorder;
                }else{
                    button.style = RLMenuButtonStyleCircle;
                }
            }else
            {
                button.style = RLMenuButtonStyleNone;

            }
        }
    }

}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
- (CGFloat)widthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}
- (CGFloat)heightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}
@end
