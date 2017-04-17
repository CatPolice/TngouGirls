//
//  WaterfallFlowLayout.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WaterfallFlowLayout;

@protocol WaterfallFlowLayoutDelegate <NSObject>

@required
- (CGFloat)waterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout;
- (CGFloat)columnMarginInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout;
- (CGFloat)rowMarginInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout;
- (UIEdgeInsets)edgeInsetsInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout;

@end


@interface WaterfallFlowLayout : UICollectionViewLayout
@property (nonatomic ,weak) id<WaterfallFlowLayoutDelegate> delegate;
@end
