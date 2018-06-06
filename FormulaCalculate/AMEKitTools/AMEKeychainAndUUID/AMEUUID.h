//
//  AMEUUID.h
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMEKeychain.h"
@interface AMEUUID : NSObject

/**
 读取uuid并存入keychain

 @return uuid
 */
+ (NSString *)getUUID;

/**
 删除UUID
 */
+ (void)deleteUUID;
@end
