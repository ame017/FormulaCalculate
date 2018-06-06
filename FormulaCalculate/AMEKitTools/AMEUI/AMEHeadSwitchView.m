//
//  AMEHeadSwitchView.m
//  AMEKit
//
//  Created by AME on 2017/9/9.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "AMEHeadSwitchView.h"
#import "AMEHeader.h"

@interface AMEHeadSwitchView ()
@property (nonatomic, strong) UIButton * leftButton;
@property (nonatomic, strong) UIButton * rightButton;

@property (nonatomic, strong) UIColor * tintColor;
@end

@implementation AMEHeadSwitchView
#pragma mark - init
- (instancetype)initWithLeftText:(NSString *)leftText rightText:(NSString *)rightText tintColor:(UIColor *)tintColor{
    self = [super init];
    if (self) {
        _isLeft = YES;
        _tintColor = tintColor;
        
        self.layer.cornerRadius = 4.0f;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0f;
        
        [self.leftButton setTitle:leftText forState:UIControlStateNormal];
        [self.rightButton setTitle:rightText forState:UIControlStateNormal];
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        
        //layout
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(self).multipliedBy(0.5);
        }];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo(self).multipliedBy(0.5);
        }];
    }
    return self;
}

#pragma mark - buttonClick
- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        self.isLeft                  = YES;
        _leftButton.selected         = YES;
        _leftButton.backgroundColor  = [UIColor whiteColor];
        _rightButton.selected        = NO;
        _rightButton.backgroundColor = self.tintColor;
    }else{
        self.isLeft                  = NO;
        _leftButton.selected         = NO;
        _leftButton.backgroundColor  = self.tintColor;
        _rightButton.selected        = YES;
        _rightButton.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - getter & setter

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.backgroundColor = [UIColor whiteColor];
        _leftButton.selected        = YES;
        _leftButton.tag             = 100;
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_leftButton setTitleColor:self.tintColor forState:UIControlStateSelected];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = self.tintColor;
        _rightButton.selected        = NO;
        _rightButton.tag             = 101;
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_rightButton setTitleColor:self.tintColor forState:UIControlStateSelected];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (void)setIsLeft:(BOOL)isLeft{
    _isLeft = isLeft;
    if (self.delegate && [self.delegate respondsToSelector:@selector(headSwitchViewDidChangeSide:isLeft:)]) {
        [self.delegate headSwitchViewDidChangeSide:self isLeft:isLeft];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
