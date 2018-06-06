//
//  AMENetworkTool.h
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMENetworkTool : NSObject

/**
 获取当前网络时间

 @param completion 获取后的操作
 */
+ (void)getInternetDateWithCompletion:(void(^)(NSDate * date,BOOL isError))completion;


+ (NSDictionary *)getJsonDictionaryWithString:(NSString *)string;

@end
