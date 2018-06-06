//
//  NSString+Calculate.h
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Calculate)


/**
 判断字符串是否是 + - * /运算符

 @return 结果
 */
- (BOOL)fc_isOperator;

/**
 判断字符串是否是变量
 
 @return 结果
 */
- (BOOL)fc_isVariable;

@end
