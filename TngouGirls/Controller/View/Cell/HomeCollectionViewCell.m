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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end
@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setConfigData:(ImageList *)model withIndex:(NSIndexPath *)indexPath{
    _activityView.hidden = NO;
    [_activityView startAnimating];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_activityView stopAnimating];
        _activityView.hidden = YES;
    }];
    
    self.titleLab.text = model.title;
}
@end
