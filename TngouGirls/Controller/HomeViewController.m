//
//  HomeViewController.m
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "HomeViewController.h"
#import "ImageCategory.h"
#import "RLMenuView.h"
#import "WaterfallFlowLayout.h"
#import "HomeCollectionViewCell.h"
#import "MJRefresh.h"
#import "ImageList.h"
#import "DetailedViewController.h"

static NSString *HomeCollectionViewCellidentifier = @"HomeCollectionViewCellidentifier";

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterfallFlowLayoutDelegate>
{
    __weak IBOutlet UIView *_collectionViewSuperView;
    
    NSMutableArray *_items;
    
    NSInteger currentPage;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet RLMenuView *menuButton;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    currentPage = 1;
    [self buildMenuView];
    [self buildView];
    [self addRefresh];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_collectionView setFrame:_collectionViewSuperView.bounds];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma ======================
- (void)buildMenuView{
    __weak typeof(self)weakSelf = self;
    [ImageCategory getImageCategory:nil Success:^(id responeObject, NSMutableArray *items) {
        
        NSLog(@"%@", items);
        weakSelf.menuButton.items = [NSArray arrayWithArray:items];
        weakSelf.menuButton.xSpacing = 5;
        [weakSelf.menuButton selectIndex:0];
        
//        ImageCategory *obj = (ImageCategory *)[items firstObject];
//        [weakSelf loadImageListFromCategory:@{@"id":obj.ID} withLoad:NO];
        
    } Failure:^(NSError *error) {
        
    }];
    
    
    [self.menuButton setTabClickBlock:^(NSInteger index, UIButton *button, id item) {
        ImageCategory *obj = (ImageCategory *)item;
        [weakSelf loadImageListFromCategory:@{@"id":obj.ID} withLoad:NO];
    }];
    
    [self.menuButton setTitleForMenuItem:^NSString *(NSInteger index, id item) {
        ImageCategory *obj = (ImageCategory *)item;
        return obj.title;
    }];

}

- (void)buildView{
    WaterfallFlowLayout *layout = [[WaterfallFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:_collectionViewSuperView.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionViewSuperView addSubview:_collectionView];
    layout.delegate = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:HomeCollectionViewCellidentifier];
}

- (void)addRefresh{
    //    __weak UICollectionView *tab = _collectionView;
    __weak typeof(self)weakSelf = self;
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _collectionView.mj_footer.automaticallyChangeAlpha = YES;
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf loadImageListFromCategory:@{} withLoad:YES];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    _collectionView.mj_footer.hidden = _items.count == 0;
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeCollectionViewCellidentifier forIndexPath:indexPath];
    ImageList *obj = (ImageList *)[_items objectAtIndex:indexPath.row];
    [cell setConfigData:obj withIndex:indexPath];
    return cell;
}

- (CGFloat)waterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth{
    
    return itemWidth * (270 + arc4random() % 40) / 200;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageList *obj = (ImageList *)[_items objectAtIndex:indexPath.row];
    NSString *webUrl = [NSString stringWithFormat:@"%@%@%@",URI_BASE_SERVER,URI_INTERFACES_TNFS_SHOW,obj.ID];
    DetailedViewController *dt = [[DetailedViewController alloc] init];
    dt.webUrl = webUrl;
    [self.navigationController pushViewController:dt animated:YES];
}


- (void)loadImageListFromCategory:(NSDictionary *)par withLoad:(BOOL)isLoad{
    
    NSMutableDictionary *p = [[NSMutableDictionary alloc] initWithDictionary:par];
    
    if (!isLoad) {
        [p setObject:[NSNumber numberWithInteger:1] forKey:@"page"];
        currentPage = 1;
    }else{
        [p setObject:[NSNumber numberWithInteger:(currentPage)] forKey:@"page"];
    }
    
    
    [ImageList getImageList:p Success:^(id responeObject, NSMutableArray *items) {
        
        if (isLoad) {
            [_items addObjectsFromArray:items];
        }else{
            _items = [[NSMutableArray alloc] initWithArray:items];
        }
        currentPage = currentPage + 1;
        
        [_collectionView reloadData];
        
        [_collectionView.mj_footer endRefreshing];
    } Failure:^(NSError *error) {
        [_collectionView.mj_footer endRefreshing];
    }];
}

@end
