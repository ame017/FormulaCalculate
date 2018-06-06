//
//  FCCalculater.h
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCCalculater : NSObject

/**
 单例方法

 @return 返回一个单例
 */
+ (instancetype)share;

/**
 把double类型转换成字符串,并去掉末尾多余的0

 @param num 要转换的数值
 @return 转完的字符串
 */
- (NSString *)fc_doubleToString:(double)num;

/**
 根据公式生成变量模型数组

 @param string 公式
 @return 变量模型数组
 */
- (NSMutableArray<FCCalculateCellModel *> *)fc_splitVariableToArrayWithString:(NSString *)string;

/**
 计算

 @param string 计算式
 @return 计算结果
 */
- (double)fc_calculateWithString:(NSString *)string;

/**
 根据公式和变量值生成计算式

 @param array 变量模型数组
 @param formula 公式
 @return 计算式
 */
- (NSString *)fc_makeCalculateString:(NSMutableArray<FCCalculateCellModel *> *)array formula:(NSString *)formula;

/**
 检查公式是否有问题

 @param formula 公式
 @return 结果
 */
- (BOOL)fc_checkFormla:(NSString *)formula;

@end
