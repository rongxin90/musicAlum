//
//  GRXNavigetionController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2019/1/9.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXNavigetionController.h"

@interface GRXNavigetionController ()

@end

@implementation GRXNavigetionController


//一个类只会调用一次，在一个类被引用的时候调用
+(void)initialize{
    //获得整个项目的导航栏
    
    UINavigationBar * nav = [UINavigationBar appearance];
    
    [nav setBarTintColor:[UIColor blackColor]];

    //设置导航字体和颜色
    [nav setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        // 判断是否传过来的是根控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
