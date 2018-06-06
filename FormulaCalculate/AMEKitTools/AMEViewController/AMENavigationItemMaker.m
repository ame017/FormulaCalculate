//
//  AMENavigationItemMaker.m
//  AMEKit
//
//  Created by AME on 2017/9/8.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "AMENavigationItemMaker.h"
#import "UIControl+Enlarge.h"

#define IMAGE_TITLE_GAP 3

@interface AMENavigationItemMaker ()
@property (nonatomic, strong) NSMutableArray<UIBarButtonItem *> * leftButtonArray;
@property (nonatomic, strong) NSMutableArray<UIBarButtonItem *> * rightButtonArray;
@end

@implementation AMENavigationItemMaker

- (UIControl *)addButton:(ItemButtonDirection)direction image:(UIImage *)image title:(NSString *)title font:(UIFont *)titleFont color:(UIColor *)titleColor imageSize:(CGSize)imageSize enlargeEdge:(UIEdgeInsets)enlargeEdge{
    UIView * contentView = [UIControl new];
    contentView.userInteractionEnabled = NO;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    imageView.image = image;
    [contentView addSubview:imageView];
    if (title && ![title isEqualToString:@""]) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(imageSize.width+IMAGE_TITLE_GAP, 0, 100, 0)];
        label.text = title;
        if (titleFont) {
            label.font = titleFont;
        }
        if (titleColor) {
            label.textColor = titleColor;
        }
        [label sizeToFit];
        label.center = CGPointMake(label.center.x, imageView.center.y);
        [contentView addSubview:label];
        contentView.frame = CGRectMake(enlargeEdge.left, enlargeEdge.top, imageSize.width+IMAGE_TITLE_GAP+label.frame.size.width, imageSize.height);
    }else{
        contentView.frame = CGRectMake(enlargeEdge.left, enlargeEdge.top, imageSize.width, imageSize.height);
    }
//    [control setEnlargeEdgeWithTop:enlargeSize.height/2.0 right:enlargeSize.width/2.0 bottom:enlargeSize.height/2.0 left:enlargeSize.width/2.0];
    UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, contentView.frame.size.width + enlargeEdge.left + enlargeEdge.right, contentView.frame.size.height + enlargeEdge.top + enlargeEdge.bottom)];
    [control addSubview:contentView];
    NSInteger index = 0;
    switch (direction) {
        case ItemButtonDirectionLeft:
            index = self.leftButtonArray.count;
            [self.leftButtonArray addObject:[[UIBarButtonItem alloc]initWithCustomView:control]];
            self.navigationItem.leftBarButtonItems = self.leftButtonArray;
            control.tag = 10000;
            break;
        case ItemButtonDirectionRight:
            index = self.rightButtonArray.count;
            [self.rightButtonArray addObject:[[UIBarButtonItem alloc]initWithCustomView:control]];
            self.navigationItem.rightBarButtonItems = self.rightButtonArray;
            control.tag = 20000;
    }
    control.tag += index;
    [control addTarget:self action:@selector(navigationButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    return control;
}

- (void)navigationButtonDidClick:(UIControl *)control{
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationButtonDidClick:index:)]) {
        NSInteger dir = control.tag / 10000;
        ItemButtonDirection direction;
        if (dir == 1) {
            direction  = ItemButtonDirectionLeft;
        }else{
            direction = ItemButtonDirectionRight;
        }
        NSInteger index = control.tag % 10000;
        [self.delegate navigationButtonDidClick:direction index:index];
    }
}

- (void)makeTitleView:(UIView *)view{
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [contentView addSubview:view];
    self.navigationItem.titleView = contentView;
}


- (NSMutableArray<UIBarButtonItem *> *)leftButtonArray{
    if(!_leftButtonArray){
        _leftButtonArray = ({
            NSMutableArray * object = [[NSMutableArray alloc]init];
            object;
       });
    }
    return _leftButtonArray;
}

- (NSMutableArray<UIBarButtonItem *> *)rightButtonArray{
    if(!_rightButtonArray){
        _rightButtonArray = ({
            NSMutableArray * object = [[NSMutableArray alloc]init];
            object;
       });
    }
    return _rightButtonArray;
}
@end
