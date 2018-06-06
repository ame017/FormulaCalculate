//
//  AMENavigationController.m
//  TJSWorking
//
//  Created by ame on 2018/1/8.
//  Copyright © 2018年 tejisong. All rights reserved.
//

#import "AMENavigationController.h"

@interface AMENavigationController ()

@end

@implementation AMENavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //如果现在push的不是栈底控制器（最先push进来的那个控制器）
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
