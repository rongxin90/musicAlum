//
//  BaseNavgationController.m
//  musicAlum
//
//  Created by 桂荣信 on 2019/1/10.
//  Copyright © 2019年 guirongxin. All rights reserved.
//

#import "BaseNavgationController.h"

@interface BaseNavgationController ()

@end

@implementation BaseNavgationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *nav = [UINavigationBar appearance];
    self.navigationBar.barTintColor = [UIColor blackColor];
    [nav setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
