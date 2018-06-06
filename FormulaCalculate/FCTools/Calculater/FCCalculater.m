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
            BOOL isFind = NO;
            for (FCCalculateCellModel * model in varArray) {
                if ([model.varName isEqualToString:sub]) {
                    isFind = YES;
                    break;
                }
            }
            if (!isFind) {
                FCCalculateCellModel * model = [FCCalculateCellModel new];
                model.varName = sub;
                [varArray addObject:model];
            }
        }
    }
    return varArray;
}



- (double)fc_singleCalculate:(NSString *)string{
    NSMutableArray<NSString *> * operatorArray = [NSMutableArray new];
    for (int i = 0; i < string.length; i++) {
        NSString * sub = [string substringWithRange:NSMakeRange(i, 1)];
        if ([sub fc_isOperator] && ![[string substringWithRange:NSMakeRange(i-1, 1)]isEqualToString:@"["]) {
            [operatorArray addObject:sub];
        }
    }
    NSMutableArray<NSString *> * valueArray = [string ame_componentsSeparatedFromString:@"[" toString:@"]"].mutableCopy;
    NSLog(@"%@",operatorArray);
    NSLog(@"%@",valueArray);
    
    int i = 0;
    while (1) {
        if (i >= operatorArray.count) {
            break;
        }
        double temp = 0;
        BOOL isFind = NO;
        if ([operatorArray[i] isEqualToString:@"*"]) {
            isFind = YES;
            temp = valueArray[i].doubleValue * valueArray[i+1].doubleValue;
        }
        if ([operatorArray[i] isEqualToString:@"/"]) {
            isFind = YES;
            if (valueArray[i+1].doubleValue == 0) {
                //这里弹窗
                return 0;
            }
            temp = valueArray[i].doubleValue / valueArray[i+1].doubleValue;
        }
        if (isFind == YES) {
            [operatorArray removeObjectAtIndex:i];
            [valueArray removeObjectAtIndex:i];
            [valueArray removeObjectAtIndex:i];
            [valueArray insertObject:[self fc_doubleToString:temp] atIndex:i];
            NSLog(@"%@",operatorArray);
            NSLog(@"%@",valueArray);
            i = 0;
        }else{
            i++;
        }
    }
    //这里应该得到一个没有乘除法的
    while (1) {
        if (operatorArray.count == 0) {
            break;
        }else{
            double temp = 0;
            if ([operatorArray[0] isEqualToString:@"+"]) {
                temp = valueArray[0].doubleValue + valueArray[1].doubleValue;
            }
            if ([operatorArray[0] isEqualToString:@"-"]) {
                temp = valueArray[0].doubleValue - valueArray[1].doubleValue;
            }
            [operatorArray removeObjectAtIndex:0];
            [valueArray removeObjectAtIndex:0];
            [valueArray removeObjectAtIndex:0];
            [valueArray insertObject:[self fc_doubleToString:temp] atIndex:0];
        }
    }
    return valueArray[0].doubleValue;
}
- (NSString *)fc_removeParenthesis:(NSString *)string{
    NSString * ansString = string;
    while (1) {
        int left = 0;
        int interval = 0;
        BOOL isFind = NO;
        for (int i = 0; i < ansString.length; i++) {
            NSString * sub = [ansString substringWithRange:NSMakeRange(i, 1)];
            if ([sub isEqualToString:@"("]) {
                isFind = YES;
                left = i;
            }
            if ([sub isEqualToString:@")"]) {
                interval = i-left;
                break;
            }
        }
        if (isFind == NO) {
            return ansString;
        }
        NSString * raw = [[[ansString substringWithRange:NSMakeRange(left, interval)]
                           stringByReplacingOccurrencesOfString:@"(" withString:@""]
                          stringByReplacingOccurrencesOfString:@")" withString:@""];
        NSLog(@"%@",raw);
        double temp = [self fc_singleCalculate:raw];
        NSLog(@"%lf",temp);
        ansString = [NSString stringWithFormat:@"%@[%@]%@",[ansString substringToIndex:left],[self fc_doubleToString:temp],[ansString substringFromIndex:left+interval+1]];
        NSLog(@"%@",ansString);
    }
}
- (double)fc_calculateWithString:(NSString *)string{
    NSString * tempString = [self fc_removeParenthesis:string];
    return [self fc_singleCalculate:tempString];
}

- (NSString *)fc_makeCalculateString:(NSMutableArray<FCCalculateCellModel *> *)array formula:(NSString *)formula{
    NSString * ansString = formula;
    for (FCCalculateCellModel * model in array) {
        NSLog(@"%@",model.varName);
        ansString = [ansString stringByReplacingOccurrencesOfString:model.varName withString:[NSString stringWithFormat:@"[%@]",[self fc_doubleToString:model.varValue]]];
    }
    NSLog(@"ansString:%@",ansString);
    return ansString;
}

- (BOOL)fc_checkFormla:(NSString *)formula{
    if (kStringIsEmpty(formula)) {
        return NO;
    }
    int parenthesesMatching = 0;
    int operatorCount = 0;
    int varCount = 0;
    for (int i = 0; i < formula.length; i++) {
        NSString * sub = [formula substringWithRange:NSMakeRange(i, 1)];
        //符号不能相连
        if ([sub fc_isOperator]) {
            operatorCount++;
            if (i == 0 || i == formula.length-1) {
                return NO;
            }
            if ([[formula substringWithRange:NSMakeRange(i-1, 1)]fc_isOperator] || [[formula substringWithRange:NSMakeRange(i+1, 1)]fc_isOperator]) {
                return NO;
            }
        }
        if ([sub isEqualToString:@"("]) {
            parenthesesMatching++;
            if (i == formula.length-1) {
                return NO;
            }
            if (i > 0 && [[formula substringWithRange:NSMakeRange(i-1, 1)]fc_isVariable]) {
                return NO;
            }
            if (i < formula.length-1 && [[formula substringWithRange:NSMakeRange(i+1, 1)]fc_isOperator]) {
                return NO;
            }
        }
        if ([sub isEqualToString:@")"]) {
            parenthesesMatching--;
            if (i==0) {
                return NO;
            }
            if (i > 0 && [[formula substringWithRange:NSMakeRange(i-1, 1)]fc_isOperator]) {
                return NO;
            }
            if (i < formula.length-1 && [[formula substringWithRange:NSMakeRange(i+1, 1)]fc_isVariable]) {
                return NO;
            }
        }
        if ([sub fc_isVariable]) {
            varCount++;
            if (i > 0 && [[formula substringWithRange:NSMakeRange(i-1, 1)]fc_isVariable]) {
                return NO;
            }
            if (i < formula.length-1 && [[formula substringWithRange:NSMakeRange(i+1, 1)]fc_isVariable]) {
                return NO;
            }
        }
    }
    if (parenthesesMatching) {
        return NO;
    }
    if (operatorCount+1 != varCount) {
        return NO;
    }
    return YES;
}
@end
