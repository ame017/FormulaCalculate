//
//  AMEHeadSwitchView.h
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMEHeadSwitchView;
@protocol AMEHeadSwitchViewDelegate <NSObject>

@optional
- (void)headSwitchViewDidChangeSide:(AMEHeadSwitchView *)headSwitchView isLeft:(BOOL)isLeft;

@end

@interface AMEHeadSwitchView : UIView

@property (nonatomic, assign) BOOL isLeft;
@property (nonatomic, weak) id<AMEHeadSwitchViewDelegate> delegate;

/**
 根据左右文字返回View
 
 @param leftText 左标题
 @param rightText 右标题
 @return 你说呢~~
 */
- (instancetype)initWithLeftText:(NSString *)leftText rightText:(NSString *)rightText tintColor:(UIColor *)tintColor;

@end
