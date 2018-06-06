//
//  AMEUUID.m
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "AMEUUID.h"
#import "AMEHeader.h"
#define DIC_KEY @"AME_uuid"
#define KEYCHAIN_KEY @"AME_UUID"

@implementation AMEUUID

+ (NSString *)getUUID{
    NSString * uuid = [AMEUUID getUUIDStringFromKeychain];
    if (kStringIsEmpty(uuid)) {
        uuid = [AMEUUID saveUUIDToKeychain];
    }
    return uuid;
}

+ (void)deleteUUID{
    NSString * uuid = [AMEUUID getUUIDStringFromKeychain];
    if (kStringIsEmpty(uuid)) {
        return;
    }
    [AMEKeychain delete:KEYCHAIN_KEY];
    NSLog(@"deleteUUIDDone");
}

+ (NSString *)getUUIDStringFromKeychain{
    NSDictionary * dic = (NSDictionary *)[AMEKeychain load:KEYCHAIN_KEY];
    if (dic) {
        NSString * uuid = dic[DIC_KEY];
        if (uuid && ![uuid isEqualToString:@""]) {
            NSLog(@"load UUID-------> %@",uuid);
            return uuid;
        }
    }
    NSLog(@"no UUID in keychain");
    return nil;
}

+ (NSString *)saveUUIDToKeychain{
    NSString * uuid = [AMEUUID getUUIDString];
    NSLog(@"getNewUUID--------> %@",uuid);
    NSDictionary * dic = @{DIC_KEY:uuid};
    [AMEKeychain save:KEYCHAIN_KEY data:dic];
    NSLog(@"save uuid done");
    return uuid;
}


+ (NSString *)getUUIDString
{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault , uuidRef);
    NSString *uuidString = [(__bridge NSString*)strRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(strRef);
    CFRelease(uuidRef);
    return uuidString;
}
@end
