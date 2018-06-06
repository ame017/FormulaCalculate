//
//  FCCalculater.h
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCCalculater : NSObject

+ (instancetype)share;

- (NSString *)fc_doubleToString:(double)num;

- (NSMutableArray<FCCalculateCellModel *> *)fc_splitVariableToArrayWithString:(NSString *)string;

@end
