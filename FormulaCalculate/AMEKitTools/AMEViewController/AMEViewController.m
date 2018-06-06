//
//  AMEViewController.m
//  AMEKit
//
//  Created by AME on 2017/9/8.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "AMEViewController.h"

#define BACK_IMAGE_NAME @"btn_back_normal"
#define BACK_IMAGE_SIZE CGSizeMake(22, 22)

@interface AMEViewController ()<AMENavigationItemMakerDelegate>

@end

@implementation AMEViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 //   [self.navigationItemMaker addBackButtonWithImage:[UIImage imageNamed:BACK_IMAGE_NAME] title:nil font:nil color:nil imageSize:BACK_IMAGE_SIZE];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBackIndicatorImage:[[UIImage imageNamed:BACK_IMAGE_NAME] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[[UIImage imageNamed:BACK_IMAGE_NAME]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
//    if (self.navigationController) {
//        self.navigationController.delegate = self;
//    }
//    if (self.tabBarController) {
//        self.tabBarController.delegate = self;
//    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //bugFix
    for (UIBarButtonItem * item in self.navigationItem.rightBarButtonItems) {
        if (!kStringIsEmpty(item.title)) {
            item.enabled = NO;
            item.enabled = YES;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AMENavigationItemMaker *)navigationItemMaker{
    if(!_navigationItemMaker){
        _navigationItemMaker = ({
            AMENavigationItemMaker * object = [[AMENavigationItemMaker alloc]init];
            object.navigationItem           = self.navigationItem;
            object.delegate                 = self;
            object;
       });
    }
    return _navigationItemMaker;
}
@end
