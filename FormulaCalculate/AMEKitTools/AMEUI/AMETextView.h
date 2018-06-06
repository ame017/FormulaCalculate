//
//  AMETextView.h
//  exhibiton_vino
//
//  Created by Vino－lgc on 16/10/19.
//  Copyright © 2016年 AME. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^returnKeyEvent)(AMETextField * textField);

@interface AMETextView : UITextView
//@property (nonatomic, strong) NSString * placeholder;
//@property (nonatomic, strong) UIColor  * placeholderColor;

/**
 最大长度
 */
@property (nonatomic, assign) NSInteger maxLength;

/**
 最小长度
 */
@property (nonatomic, assign) NSInteger minLength;

@property (nonatomic, strong) NSString * viewName;

@property (copy) void(^returnKeyEvent)(AMETextView * textView);

/**
 一个属性 用于判断是否可以为空
 */
@property (nonatomic, assign) BOOL canEmpty;

/**
 是否可以换行 默认为yes (设置不换行会占用代理接口 如果需要在外面设置代理请把里面的换行代码复制出去)
 */
@property (nonatomic, assign) BOOL canCangeLine;

- (BOOL)checkTextEnableWithFirstResponder:(BOOL)firstResponder;

@end
