//
//  UIAlertController+Maker.m
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "UIAlertController+Maker.h"
#import "AMEHeader.h"



@implementation UIAlertController (Maker)

- (void)show{
    [[AMETool getTopPresentedViewController] presentViewController:self animated:YES completion:^{
        NSLog(@"alertPresentedDone:%@",self);
    }];
}

+ (instancetype)okAlertWithMessage:(NSString *)message okEvent:(void(^)())okEvent isShow:(BOOL)isShow{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (okEvent) {
            okEvent();
        }
    }];
    [alert addAction:okAction];
    if (isShow) {
        [alert show];
    }
    return alert;
}

+ (instancetype)cancelAlertWithMessage:(NSString *)message okEvent:(void (^)())okEvent cancelEvent:(void (^)())cancelEvent isShow:(BOOL)isShow{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (okEvent) {
            okEvent();
        }
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelEvent) {
            cancelEvent();
        }
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    if (isShow) {
        [alert show];
    }
    return alert;
}

+ (instancetype)sheetWithTitle:(NSString *)title message:(NSString *)message cancelEvent:(void (^)())cancelEvent{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelEvent) {
            cancelEvent();
        }
    }];
    [alert addAction:cancelAction];
    return alert;
}

//+ (instancetype)showAlertWithAlertType:(AMEAlertType)type style:(UIAlertControllerStyle)style Message:(NSString *)message okEvent:(void (^)())okEvent cancelEvent:(void (^)())cancelEvent{
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:style];
//    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        if (cancelEvent) {
//            cancelEvent();
//        }
//    }];
//    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        if (cancelEvent) {
//            cancelEvent();
//        }
//    }];
//    if (style == UIAlertControllerStyleActionSheet || type == AMEAlertTypeOkAndCancel) {
//        [alert addAction:];
//    }
//    
//    return alert;
//}

@end
