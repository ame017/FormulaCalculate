//
//  AMETool.m
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "AMETool.h"

@implementation AMETool

+ (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}

+ (BOOL)preferredLanguageIsChinese{
    NSString * language = [AMETool getPreferredLanguage];
    if (!([language isEqualToString:@"zh-Hans-CN"]||[language isEqualToString:@"zh-Hans"]||[language isEqualToString:@"zh-Hant-CN"]||[language isEqualToString:@"zh-Hant"])) {
        return NO;
    }
    return YES;
}

+ (UIViewController *)getTopPresentedViewController{
    UIViewController * topVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVc.presentedViewController) {
        topVc = topVc.presentedViewController;
    }
    return topVc;
}

+ (BOOL)inputIsChinese{
    BOOL isChinese;//判断当前输入法是否是中文
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    if ([current.primaryLanguage isEqualToString: @"en-US"]) {
        isChinese = NO;
    }else{
        isChinese = YES;
    }
    return isChinese;
}
@end
