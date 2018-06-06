//
//  AMEImageTextView.m
//  exhibiton_vino
//
//  Created by Vino－lgc on 2017/1/12.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "AMEImageTextView.h"

@implementation AMEImageTextView

- (instancetype)init{
    self = [super init];
    if (self) {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        
        _label = [UILabel new];
        _label.font = [UIFont fontWithName:SYSTEM_FONT size:12.0f];
        _label.numberOfLines = 2;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(_imageView.mas_width);
        }];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_imageView.mas_bottom).offset(5);
            make.centerX.mas_equalTo(_imageView);
            make.left.right.mas_equalTo(0);
        }];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        
        _label = [UILabel new];
        _label.numberOfLines = 0;
        _label.font = [UIFont fontWithName:SYSTEM_FONT size:12.0f];
        [self addSubview:_label];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(_imageView.mas_width);
        }];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_imageView.mas_bottom).offset(5);
            make.centerX.mas_equalTo(_imageView);
            make.left.right.mas_equalTo(0);
        }];
    }
    return self;
}



@end
