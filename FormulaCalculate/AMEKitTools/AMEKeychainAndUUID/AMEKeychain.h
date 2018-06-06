//
//  AMEKeyChain.h
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMEKeychain : NSObject
/**
 *  用KeyChain保存
 */
+(void)save:(NSString *)service data:(id)data;
/**
 *  从KeyChain取出
 */
+(id)load:(NSString *)service;
/**
 *  从KeyChain中删除
 */
+ (void)delete:(NSString *)service;
@end
