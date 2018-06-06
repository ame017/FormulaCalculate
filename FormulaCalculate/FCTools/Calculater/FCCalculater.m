//
//  FCCalculater.m
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import "FCCalculater.h"
#import "FCCalculateCellModel.h"

static FCCalculater * _fc_calculater = nil;

@implementation FCCalculater

+ (instancetype)share{
    if (!_fc_calculater) {
        _fc_calculater = [[self alloc]init];
    }
    return _fc_calculater;
}

- (NSString *)fc_doubleToString:(double)num{
    NSString * dStr = [NSString stringWithFormat:@"%lf", num];
    NSDecimalNumber * dn = [NSDecimalNumber decimalNumberWithString:dStr];
    return dn.stringValue;
}

- (NSMutableArray<FCCalculateCellModel *> *)fc_splitVariableToArrayWithString:(NSString *)string{
    NSMutableArray * varArray = [NSMutableArray new];
    for (int i = 0; i < string.length; i++) {
        NSString * sub = [string substringWithRange:NSMakeRange(i, 1)];
        if ([sub fc_isVariable]) {
            FCCalculateCellModel * model = [FCCalculateCellModel new];
            model.varName = sub;
            [varArray addObject:model];
        }
    }
    return varArray;
}

@end
