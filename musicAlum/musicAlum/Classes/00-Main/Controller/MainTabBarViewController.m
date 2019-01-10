//
//  MainTabBarViewController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2019/1/9.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "UIView+Frame.h"
#import "GRXTabBar.h"
#import "GRXNavigetionController.h"

#import "GRXHomeController.h"
#import "SettingController.h"
#import "TimeController.h"
#import "dongtaiController.h"


#define randomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface MainTabBarViewController ()<GRXTabbarDelegate>

@property (weak, nonatomic) UIView *adView;

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    //添加子控制器
    [self addChildController];
    
    //添加自定义tabbar
    [self addTabBarView];
}



-(void)targetMethod
{
    [self.adView removeFromSuperview];
}



#pragma mark--GRXTabBarViewDelegate
-(void)grx_bar:(GRXTabbar *)bar ClickAtIndexFrom:(NSInteger)from To:(NSInteger)index{
    NSLog(@"%ld---%ld",(long)from,(long)index);

    self.selectedIndex = index;
}


/*
 问题：自定义的tabbarView上的按钮创建个数和Main子控制器的创建个数不同步
 解决：把自定义创建的tabbarView替换掉系统的UITabBar的view，再做一些其他处理
 */

//自定义tabbar
- (void)addTabBarView{
    
    //创建tabbar
    GRXTabbar *tabbar  = [[GRXTabbar alloc] init];
    tabbar.frame = self.tabBar.bounds;
    tabbar.delegate = self;
//    [self.view addSubview:tabbar];
    [self.tabBar addSubview:tabbar];
    
    //添加item
    [tabbar addtabbarItemWithNormalImage:@"home-normal" andSelectedImage:@"home-selected" WithTitle:@"首页"];
    [tabbar addtabbarItemWithNormalImage:@"dong-nor" andSelectedImage:@"dong-sel" WithTitle:@"动态"];
    [tabbar addtabbarItemWithNormalImage:@"circle" andSelectedImage:@"circle" WithTitle:nil];
    [tabbar addtabbarItemWithNormalImage:@"shalou-normal" andSelectedImage:@"shalou-selected" WithTitle:@"时光"];
    [tabbar addtabbarItemWithNormalImage:@"setting-normal" andSelectedImage:@"setting-selected" WithTitle:@"设置"];
    
}

- (void)dealloc{
    NSLog(@"MainTabBarViewController");
}

//添加子控制器
- (void)addChildController{
    GRXHomeController *rootVC1 = [[GRXHomeController alloc] init];
//    rootVC1.view.backgroundColor = randomColor;
    [self grx_addChildViewControllerWithRootVC:rootVC1 normalImage:@"icon_tabbar_home~iphone" withSelectedImage:@"icon_tabbar_home_sel~iphone"];

    dongtaiController *rootVC2 = [[dongtaiController alloc] init];
    rootVC2.view.backgroundColor = randomColor;
    [self grx_addChildViewControllerWithRootVC:rootVC2 normalImage:@"icon_tabbar_store~iphone" withSelectedImage:@"icon_tabbar_store_sel~iphone"];
    
    
    UIViewController *rootVC3 = [[UIViewController alloc] init];
    rootVC3.view.backgroundColor = randomColor;
    [self grx_addChildViewControllerWithRootVC:rootVC3 normalImage:@"icon_tabbar_tel~iphone" withSelectedImage:@"icon_tabbar_tel_sel~iphone"];
    
    
    TimeController *rootVC4 = [[TimeController alloc] init];
    rootVC4.view.backgroundColor = randomColor;
    [self grx_addChildViewControllerWithRootVC:rootVC4 normalImage:@"icon_tabbar_forum~iphone" withSelectedImage:@"icon_tabbar_forum_sel~iphone"];
    
    
    SettingController *rootVC5 = [[SettingController alloc] init];
    rootVC5.view.backgroundColor = randomColor;
    [self grx_addChildViewControllerWithRootVC:rootVC5 normalImage:@"icon_tabbar_mine~iphone" withSelectedImage:@"icon_tabbar_mine_sel~iphone"];

}

- (void)grx_addChildViewControllerWithRootVC:(UIViewController *)viewController normalImage:(NSString *)norImage withSelectedImage:(NSString *)selImage{
    GRXNavigetionController *navi = [[GRXNavigetionController alloc] initWithRootViewController:viewController];
    navi.tabBarItem.enabled = NO;
    
    [self addChildViewController:navi];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
