//
//  FCCalculateCellModel.h
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCCalculateCellModel : NSObject

@property (nonatomic, copy) NSString * varName;
@property (nonatomic, assign) double varValue;
@property (nonatomic, assign) BOOL isValuation;

@end
