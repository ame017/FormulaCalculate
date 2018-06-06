//
//  AMEHeader.h
//  AMEKit
//
//  Created by AME on 2017/9/8.
//  Copyright © 2017年 AME. All rights reserved.
//

#ifndef AMEHeader_h
#define AMEHeader_h
/*----------------官方类库----------------*/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <WebKit/WebKit.h>
#import "AppDelegate.h"
/*----------------官方类库----------------*/

/*----------------自己写的----------------*/
//AMEViewController
#import "AMEViewController.h"
#import "AMENavigationItemMaker.h"
#import "AMEQRScanViewController.h"
#import "AMENavigationController.h"

//AMETool
#import "AMENetworkTool.h"
#import "AMETool.h"
#import "AMEMD5Tool.h"

//keychain & uuid
#import "AMEKeychain.h"
#import "AMEUUID.h"

//用于输出数组和字典
#import "NSArray+Log.h"
#import "NSDictionary+Log.h"

//location
#import "AMELocation.h"

//category
#import "UIControl+Enlarge.h"
#import "NSString+AMEString.h"
#import "UINavigationItem+Margin.h"
#import "NavigationItemMarginManager.h"
#import "UIAlertController+Maker.h"
#import "UISearchBar+BackgroundColor.h"
#import "UIImage+Size.h"
#import "UITableViewCell+Maker.h"
#import "UIView+Sub.h"

//UI
#import "AMEButton.h"
#import "AMELabel.h"
#import "AMEImageTextView.h"
#import "AMEBottomView.h"
#import "AMEScrollSwitch.h"
#import "AMETextView.h"
#import "AMEHeadSwitchView.h"
#import "AMETextField.h"

#import "AMENavigationSearchBar.h"

/*----------------自己写的----------------*/

/*----------------第三方----------------*/
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <Masonry.h>
#import <SVProgressHUD.h>
#import <IQKeyboardManager.h>
#import <UINavigationController+FDFullscreenPopGesture.h>
/*----------------第三方----------------*/

/*----------------工具宏----------------*/
//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//APP版本号
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//build号
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//系统版本号
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]
//获取当前语言
#define CURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//用10进制表示颜色，例如（255,255,255）白色
#define UIColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//用16进制表示颜色, 例如(0xFFFFFF) 白色
#define UIColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
//代理是否存在
#define kDelegateEnable(delegate,SEL) delegate && [delegate respondsToSelector:SEL]
#define kWeakSelf(self) __block __weak typeof(self)weakSelf = self

//转字符串
#define kIntToString(intValue) [NSString stringWithFormat:@"%d",intValue]
#define kFloatToString(floatValue) [NSString stringWithFormat:@"%f",floatValue]
#define kIntegerToString(integerValue) [NSString stringWithFormat:@"%ld",(long)integerValue]
#define kDoubleToString(doubleValue) [NSString stringWithFormat:@"%lf",doubleValue]
/*----------------工具宏----------------*/


/*----------------界面宏----------------*/
//WIDTH和HEIGHT
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// iPhone X
#define  IS_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)

// Status bar height.
#define  kStatusBarHeight      (IS_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  kNavigationBarHeight  44.f

// Tabbar height.
#define  kTabbarHeight         (IS_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  kTabbarSafeBottomMargin         (IS_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  kStatusBarAndNavigationBarHeight  (IS_iPhoneX ? 88.f : 64.f)

#define kViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

//比例计算
#define X_P (SCREEN_WIDTH/375.0)
#define Y_P (SCREEN_HEIGHT/667.0)

#define SYSTEM_FONT_BOLD @"Helvetica-Bold"
#define SYSTEM_FONT @"Helvetica"
/*----------------界面宏----------------*/

/*----------------输出宏----------------*/
//输出几个逗比用
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

#if DEBUG

//#define NSLog(FORMAT, ...) fprintf(stderr, "[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

#define NSLog(FORMAT, ...)                                                        \
fprintf(stderr, "(%s %s)<runClock:%ld> ->\n<%s : %d行> %s方法\n  %s\n -------\n",  \
__DATE__,                                                                         \
__TIME__,                                                                         \
clock(),                                                                          \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],        \
__LINE__,                                                                         \
__func__,                                                                         \
[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])                   \


#else

#define NSLog(FORMAT, ...) nil

#endif
/*----------------输出宏----------------*/


/*----------------tips----------------*/
/*
 statusBar字体为白色
 在plist里面设置View controller-based status bar appearance 为 NO；设置statusBarStyle UIStatusBarStyleLightContent
 
 sd加载不了的图片,试试
 [[SDWebImageDownloader sharedDownloader] setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
 
 Xcode8里边 Edit Scheme-> Run -> Arguments, 在Environment Variables里边添加
 OS_ACTIVITY_MODE ＝ Disable
 
 纪元的显示：
 G：显示AD，也就是公元
 年的显示：
 yy：年的后面2位数字
 yyyy：显示完整的年
 月的显示：
 M：显示成1~12，1位数或2位数
 MM：显示成01~12，不足2位数会补0
 MMM：英文月份的缩写，例如：Jan
 MMMM：英文月份完整显示，例如：January
 
 日的显示：
 d：显示成1~31，1位数或2位数
 dd：显示成01~31，不足2位数会补0
 星期的显示：
 EEE：星期的英文缩写，如Sun
 EEEE：星期的英文完整显示，如，Sunday
 
 上/下午的显示：
 aa：显示AM或PM
 
 小時的显示：
 H：显示成0~23，1位数或2位数(24小时制
 HH：显示成00~23，不足2位数会补0(24小时制)
 K：显示成0~12，1位数或2位数(12小時制)
 KK：显示成0~12，不足2位数会补0(12小时制)
 
 分的显示：
 m：显示0~59，1位数或2位数
 mm：显示00~59，不足2位数会补0
 
 秒的显示：
 s：显示0~59，1位数或2位数
 ss：显示00~59，不足2位数会补0
 S： 毫秒的显示
 
 时区的显示：
 z / zz /zzz ：PDT
 zzzz：Pacific Daylight Time
 Z / ZZ / ZZZ ：-0800
 ZZZZ：GMT -08:00
 v：PT
 vvvv：Pacific Time
 
 */
/*----------------tips----------------*/

#endif /* AMEHeader_h */
