//
//  AMEScrollSwitch.h
//  exhibiton_vino
//
//  Created by Vino－lgc on 2017/2/20.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMEHeader.h"

@class AMEScrollSwitch;
@protocol AMEScrollSwitchDelegate <UIScrollViewDelegate>

- (void)AMEScrollSwitchDidChangeIndex:(AMEScrollSwitch *)scrollSwitch;

@end

@interface AMEScrollSwitch : UIScrollView

/**
 标题数组
 */
@property (nonatomic, retain) NSMutableArray * titleArray;

/**
 标题的字体
 */
@property (nonatomic, retain) UIFont * font;

/**
 渲染颜色
 */
@property (nonatomic, strong) UIColor * tintColor;

/**
 title宽度,默认为30 当最小宽度*标题个数>width 则会滚动
 */
@property (nonatomic, assign) CGFloat titleWidth;

/**
 index
 */
@property (nonatomic, assign) NSInteger index;

/**
 是否有动画
 */
@property (nonatomic, assign) BOOL animated;

/**
 delegate
 */
@property (nonatomic, weak) id<UIScrollViewDelegate, AMEScrollSwitchDelegate> delegate;



/**
 初始化方法

 @param frame frame
 @param titleArray 标题数组
 @param tintColor 渲染颜色
 @return self;
 */
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray *)titleArray tintColor:(UIColor *)tintColor;

- (void)reloadViews;

@end
