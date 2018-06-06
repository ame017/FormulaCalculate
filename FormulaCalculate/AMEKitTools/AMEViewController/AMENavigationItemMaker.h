//
//  AMENavigationItemMaker.h
//  AMEKit
//
//  Created by AME on 2017/9/8.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ItemButtonDirection) {
    ItemButtonDirectionLeft,
    ItemButtonDirectionRight
};
@protocol AMENavigationItemMakerDelegate <NSObject>
@optional
- (void)navigationButtonDidClick:(ItemButtonDirection)direction index:(NSInteger)index;

@end


@interface AMENavigationItemMaker : NSObject

@property (nonatomic, strong) UINavigationItem * navigationItem;

@property (nonatomic, weak) id<AMENavigationItemMakerDelegate> delegate;

- (UIControl *)addButton:(ItemButtonDirection)direction image:(UIImage *)image title:(NSString *)title font:(UIFont *)titleFont color:(UIColor *)titleColor imageSize:(CGSize)imageSize enlargeEdge:(UIEdgeInsets)enlargeEdge;

- (void)makeTitleView:(UIView *)view;
@end
