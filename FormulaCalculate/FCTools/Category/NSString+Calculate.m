//
//  NSString+Calculate.m
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import "NSString+Calculate.h"

@implementation NSString (Calculate)

- (BOOL)fc_isOperator{
    if ([self isEqualToString:@"+"] || [self isEqualToString:@"-"] || [self isEqualToString:@"*"] || [self isEqualToString:@"/"]) {
        return YES;
    }
    return NO;
}
- (BOOL)fc_isVariable{
    if ([self characterAtIndex:0] >= 'A' && [self characterAtIndex:0] <= 'Z') {
        return YES;
    }
    return NO;
}

@end
