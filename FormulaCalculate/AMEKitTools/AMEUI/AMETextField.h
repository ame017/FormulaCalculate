//
//  AMETextField.h
//  TJSWorking
//
//  Created by ame on 2017/11/17.
//  Copyright © 2017年 tejisong. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AMETextFieldContentType){
    AMETextFieldContentTypeNormal,
    AMETextFieldContentTypeInterger,
    AMETextFieldContentTypeFloat,
    AMETextFieldContentTypeDate
};

@interface AMETextField : UITextField


/**
 包含的文本类型
 */
@property (nonatomic, assign) AMETextFieldContentType contentType;

/**
 最大长度
 */
@property (nonatomic, assign) NSInteger maxLength;

/**
 最小长度
 */
@property (nonatomic, assign) NSInteger minLength;

/**
 小数部分长度
 */
@property (nonatomic, assign) NSInteger decimalLenth;


/**
 最大值
 */
@property (nonatomic, assign) CGFloat maxNum;

/**
 最小值
 */
@property (nonatomic, assign) CGFloat minNum;

/**
 产生提示的名称
 */
@property (nonatomic, strong) NSString * fieldName;
/**
 一个属性 用于判断是否可以为空
 */
@property (nonatomic, assign) BOOL canEmpty;

@property (nonatomic, strong) NSMutableDictionary * userInfo;


/**
 检查输入的内容是否合规

 @param firstResponder 是否获得焦点
 @return 返回bool
 */
- (BOOL)checkTextEnableWithFirstResponder:(BOOL)firstResponder;

@end
