//
//  AMEBottomView.h
//  exhibiton_vino
//
//  Created by Vino－lgc on 2016/12/20.
//  Copyright © 2016年 AME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMEHeader.h"

@protocol AMEBottomViewDelegate <NSObject>

/**
 代理方法,动画是否完成
 
 @param isShow 是否是出现(用于区分出现和隐藏)
 */
- (void)animationDone:(BOOL)isShow;

@end

typedef NS_ENUM(NSUInteger, AMEBottomViewShowWay) {
    AMEBottomViewShowWayMove,/*利用移动*/
    AMEBottomViewShowWayAlpha/*利用透明渐变*/
};

@interface AMEBottomView : UIView

/**
 代理
 */
@property (nonatomic, assign) id<AMEBottomViewDelegate> delegate;


/**
 内容View;
 */
@property (nonatomic, strong) UIView * contentView;

/**
 一个信息接口
 */
@property (nonatomic, strong) NSDictionary * userInfo;


/**
 弹出后的位置,默认会根据view大小控制
 */
@property (nonatomic, assign) CGPoint showPoint;


/**
 初始位置和大小
 */
@property (nonatomic, assign) CGRect originalFrame;

/**
 出现方式
 */
@property (nonatomic, assign) AMEBottomViewShowWay showWay;


/**
 动画时长(默认0.5)
 */
@property (nonatomic, assign) CGFloat duration;

/**
 是否动画(默认yes)
 */
@property (nonatomic, assign) BOOL isAnimated;

/**
 会使移动对象更有力度(模式为alpha时无效,默认为no)
 */
@property (nonatomic, assign) BOOL powerful;


/**
 是否是show状态(只读属性,用于判断)
 */
@property (nonatomic, assign, readonly) BOOL isShow;



/**
 出现
 */
- (void)show;

/**
 消失
 */
- (void)dismiss;


@end
