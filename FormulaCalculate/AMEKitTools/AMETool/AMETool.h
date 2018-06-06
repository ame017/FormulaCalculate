//
//  AMETool.h
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMEHeader.h"

@interface AMETool : NSObject
/**
 *得到本机现在用的语言
 * en-CN 或en  英文  zh-Hans-CN或zh-Hans  简体中文   zh-Hant-CN或zh-Hant  繁体中文    ja-CN或ja  日本  ......
 */
+ (NSString*)getPreferredLanguage;

/**
 系统语言是否是中文
 */
+ (BOOL)preferredLanguageIsChinese;


/**
 取当前最上面的presentedViewController

 @return 最上面的presentedViewController
 */
+ (UIViewController *)getTopPresentedViewController;

/**
 输入法是否是中文

 @return 输入法是否是中文
 */
+ (BOOL)inputIsChinese;
@end
