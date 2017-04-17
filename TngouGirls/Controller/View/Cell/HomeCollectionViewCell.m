//
//  HomeCollectionViewCell.m
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"



@interface HomeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setConfigData:(ImageList *)model withIndex:(NSIndexPath *)indexPath{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil];
    self.titleLab.text = model.title;
}
@end
