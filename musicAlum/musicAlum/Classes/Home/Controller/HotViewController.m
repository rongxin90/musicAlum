//
//  HotViewController.m
//  musicAlum
//
//  Created by 桂荣信 on 2019/1/10.
//  Copyright © 2019年 guirongxin. All rights reserved.
//

#import "HotViewController.h"
#import "UIView+Frame.h"
#import "GRXCollectionCell.h"
#import "MJRefresh.h"
#import "CollectionItem.h"

@interface HotViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *images;

@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation HotViewController

// 注意const的位置
static NSString *const cellId = @"cellId";

/**
 *数据懒加载
 */
- (NSMutableArray *)images
{
    if (!_images) {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    //加载内容视图
    [self loadCollectionView];
    
    //数据加载
    [self loadDatas];
    
    
}

- (void)loadDatas{
    for (int i = 1; i<= 20; i++) {
        NSString *str = @"img-1";
        [self.images addObject:str];
    }
}

-(void)loadCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 49) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor blackColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.collectionView = collectionView;
    //默认【上拉加载】
    collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.view addSubview:collectionView];
    
    
    // 注册cell、sectionHeader、sectionFooter
    [collectionView registerNib:[UINib nibWithNibName:@"GRXCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
    
}
-(void)refresh{    
    
    [self.images removeAllObjects];
    
    for (int i = 1; i<= 20; i++) {
        NSString *str = @"backImage";
        [self.images addObject:str];
    }
    
    [self.collectionView reloadData];
    
    [self.collectionView.mj_header endRefreshing];
}

- (void)loadMore{
    
    for (int i = 1; i<= 20; i++) {
        NSString *str = @"img-1";
        [self.images addObject:str];
    }
    
     [self.collectionView reloadData];
    // 结束刷新
    [ self.collectionView.mj_footer endRefreshing];
}



#pragma mark --UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GRXCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    cell.backImageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){self.view.width / 2 - 5  ,self.view.height / 3};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(5, 0, 0, 0);
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}

#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor greenColor];
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    NSLog(@"ld",indexPath.row);
}


@end
