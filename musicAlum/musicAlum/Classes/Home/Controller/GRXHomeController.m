//
//  GRXHomeController.m
//  musicAlum
//
//  Created by 桂荣信 on 2019/1/10.
//  Copyright © 2019年 guirongxin. All rights reserved.
//

#import "GRXHomeController.h"
#import "GRXTabBarView.h"
#import "UIView+Frame.h"

#import "HotViewController.h"
#import "TextViewController.h"

//指定颜色
#define kGRXColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]

/**选项卡的高度*/
CGFloat const GRXAlternativeHeight = 34;

/**导航条的高度*/
CGFloat const GRXNavgationBarMaxY = 64;

// 弱引用
#define GRXWeakSelf __weak typeof(self) weakSelf = self;

#define kScreenW    [UIScreen mainScreen].bounds.size.width
#define kScreenH    [UIScreen mainScreen].bounds.size.height

@interface GRXHomeController ()<UIScrollViewDelegate>
/**选项卡的按钮数组*/
@property (nonatomic,strong)NSMutableArray *titleButtons;

/**选项卡*/
@property (nonatomic, weak) UIScrollView *alertView;

/**记录当前点击的按钮*/
@property (nonatomic, weak) UIButton *currentButton;

/**底部滚动view*/
@property (nonatomic, weak) UIView *bottomView;

/*=========内容滚动视图相关==========*/
/**内容滚动视图*/
@property (nonatomic, weak) UIScrollView *contentScrollView;

/**当前添加的tableView*/
@property (nonatomic, weak) UIView *currentView;

/**记录切换前当前滚动的tableView最终偏移量*/
@property (nonatomic,assign)CGPoint offset;

@end

@implementation GRXHomeController
/**
 *数据懒加载
 */
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [[NSMutableArray alloc] init];
    }
    return _titleButtons;
}




- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"美丽  |  音乐相册";
    
    //设置选项卡
    [self addalertView];
    
    //添加子控制器
    [self addChildViewController];
    
    //设置内容视图
    [self setUpContentScrollView];
    
    //界面一出现就加载第一个子控制器的view
    [self addChildControllerViewToScrollView];
}


#pragma mark -- 选项卡的内容设置
-(void)addalertView{
    CGRect frame = CGRectMake(0, 64, self.view.width, 34);
   
    UIScrollView *alertView = [[UIScrollView alloc] init];
    alertView.frame = frame;
    alertView.backgroundColor = [UIColor blackColor];
    alertView.showsVerticalScrollIndicator = NO;
    
//    alertView.layer.borderWidth = 0.5;
//    alertView.layer.borderColor = kGRXColor(200, 200, 200).CGColor;
    
    alertView.bounces = NO;
    //内容尺寸在添加按钮之后确定
    alertView.backgroundColor = kGRXColor(245, 245, 245);
    [self.view addSubview:alertView];
    self.alertView = alertView;
    
    //给选项卡添加按钮
    [self addAlertButton];
    
    //添加底部滚动视图
    [self addBottomView];
    
   
}

//给选项卡添加按钮
- (void)addAlertButton{
    
    NSArray *alertTitles = @[@"热门",@"美册教程",@"抖音热门",@"婚礼",@"宝宝",@"毕业季",@"成长记录",@"摄影",@"旅行",@"我拍",@"娱乐",@"最新"];

    CGFloat h = self.alertView.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGFloat widthes = 0;
    
    for (int i = 0; i < alertTitles.count; i++) {
        UIButton *alertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //把按钮保存到数组中
        [self.titleButtons addObject:alertButton];
        [alertButton setBackgroundColor:[UIColor blackColor]];
        //根据文字内容计算按钮的宽度
        CGFloat length = [alertTitles[i] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        CGFloat w = length + 15;//确定按钮的宽度
        
        
        
        [alertButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [alertButton setTitleColor:kGRXColor(255, 70, 112) forState:UIControlStateSelected];
        [alertButton setTitle:alertTitles[i] forState:UIControlStateNormal];
        alertButton.titleLabel.font = [UIFont systemFontOfSize:12];
        x = widthes;
        alertButton.tag = i;
        alertButton.frame = CGRectMake(x, y, w, h);
        //监听按钮点击
        [alertButton addTarget:self action:@selector(alertButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:alertButton];
        
        
        
        //计算出来的按钮宽度加入到widthes中，以便计算下一个按钮的位置
        widthes += w;
        
    }
    
//    NSLog(@"++++%ld",self.titleButtons.count);
    
    //根据标题的个数确定选项卡内容尺寸
    self.alertView.contentSize = CGSizeMake(widthes, 0);
    
    
    
}


//添加底部滚动View
- (void)addBottomView{
    //取出第一个按钮
    UIButton *firstTitleButton = self.alertView.subviews.firstObject;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = kGRXColor(255, 70, 112);
    bottomView.height = 2;
    bottomView.y = self.alertView.height - bottomView.height;
    [self.alertView addSubview:bottomView];
    
    self.bottomView = bottomView;
    
    firstTitleButton.selected = YES;
    self.currentButton = firstTitleButton;
    
    //这是为了一进入程序,底部滚动条就能拿到第一个按钮的label的宽度
    [firstTitleButton.titleLabel sizeToFit];// 通过这句代码计算按钮内部label的宽度
    
    //让底部滚动条的宽度跟随标题的宽度改变
    bottomView.width = firstTitleButton.titleLabel.width;//想要给宽度两边各加一点距离,只要加上总的距离就会在两边各多出一段距离
    
    //初始化底部滚动条,使界面一出现就显示在第一个按钮下面
    bottomView.centerX = firstTitleButton.centerX;
}

//选项卡按钮点击事件
- (void)alertButtonClick:(UIButton *)btn{
    
    //选中按钮
    [self selectTitleButton:btn];
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.width = btn.titleLabel.width;
        self.bottomView.centerX = btn.centerX;
        
//        让对应的view滚动到可见范围内
        CGPoint offset = self.contentScrollView.contentOffset;
        offset.x = btn.tag * self.contentScrollView.width;
        self.contentScrollView.contentOffset = offset;
        
    } completion:^(BOOL finished) {
        
//        把下一个tableView添加到内容滚动视图中
        [self addChildControllerViewToScrollView];
    }];
    
}


// 选中按钮,点击和滚动完成都会调用
- (void)selectTitleButton:(UIButton *)alertButton{
    
    self.currentButton.selected = NO;
    alertButton.selected = YES;
    self.currentButton = alertButton;
    
    //设置选中按钮滚动到中间
    [self setUpTitleButtonCenter:alertButton];
    
}

//设置标题选中居中
- (void)setUpTitleButtonCenter:(UIButton *)btn{
    
    //计算偏移量 == 选中按钮的中心点x - screen * 0.5
    CGFloat offectX = btn.center.x - kScreenW * 0.5;
    
    if (offectX < 0) {
        offectX = 0;
    }
    
    //计算最大滚动区域
    CGFloat maxOffectX = _alertView.contentSize.width - kScreenW;
    
    if (offectX > maxOffectX) {
        offectX = maxOffectX;
    }
    
    //移动
    [_alertView setContentOffset:CGPointMake(offectX, 0) animated:YES];
}

#pragma mark --设置内容视图
-(void)setUpContentScrollView{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.frame = CGRectMake(0, self.alertView.y + self.alertView.height, self.view.width, self.view.height);
    
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = NO;
    
    
    //设置代理
    contentScrollView.delegate = self;
    
    //根据子控制器的个数确定内容尺寸
    NSInteger count = self.childViewControllers.count;
//    NSLog(@"%ld",count);
    contentScrollView.contentSize = CGSizeMake(kScreenW * count, 0);
    self.contentScrollView = contentScrollView;
    [self.view addSubview:contentScrollView];
}

#pragma mark ---UIScrollViewDelegate代理
/**
 * scrollView滚动完毕\静止的时候调用这个代理方法
 * 前提:用户拖拽scrollView, 手松开以后继续滚动
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //获取对应的按钮标号
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //获取对应的按钮
    UIButton *titleButton = self.titleButtons[index];

    [self alertButtonClick:titleButton];
}

#pragma mark --添加子控制器
-(void)addChildViewController{
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor lightGrayColor];
    [self addChildViewController:[[HotViewController alloc] init]];
    [self addChildViewController:[[TextViewController alloc] init]];
    [self addChildViewController:[[HotViewController alloc] init]];
    [self addChildViewController:[[TextViewController alloc] init]];
    [self addChildViewController:[[HotViewController alloc] init]];
    [self addChildViewController:[[TextViewController alloc] init]];
    [self addChildViewController:[[HotViewController alloc] init]];
    [self addChildViewController:[[TextViewController alloc] init]];
    [self addChildViewController:[[HotViewController alloc] init]];
    [self addChildViewController:[[TextViewController alloc] init]];
    [self addChildViewController:[[HotViewController alloc] init]];
    [self addChildViewController:[[TextViewController alloc] init]];
}

//添加子控制器的视图到内容滚动视图中
- (void)addChildControllerViewToScrollView{
    
    //取出对应的子控制器
    NSInteger index = self.contentScrollView.contentOffset.x / self.contentScrollView.width;
    UIViewController *controller = self.childViewControllers[index];
    
    //    controller.tableView.delegate = self;
//    如果当前控制器的view已经添加,就直接返回
    if (controller.view.superview) {
        self.currentView = controller.view;
        return;
    };
    
    controller.view.frame = self.contentScrollView.bounds;
    
    //判断当前的View是否存在,以确定第一个View的位置
    if (self.currentView != nil) {

        //判断选项卡是否滚动到顶部
        if (self.offset.y > -GRXAlternativeHeight) {

            //如果滚动到顶部,就让所有的tableView的内容偏移量的y值向下滚动导航条和选项卡的高度之和
            self.offset = CGPointMake(0, -GRXNavgationBarMaxY-GRXAlternativeHeight);
        }

//        controller.collectionView.contentOffset = self.offset;
    }
//
    [self.contentScrollView addSubview:controller.view];
//
//    //把当前显示的View记录下来
    self.currentView = ((UIViewController *)self.childViewControllers[index]).view;
}



@end
