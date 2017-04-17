//
//  HomeCollectionViewCell.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageList.h"

@interface HomeCollectionViewCell : UICollectionViewCell
- (void)setConfigData:(ImageList *)model withIndex:(NSIndexPath *)indexPath;
@end
