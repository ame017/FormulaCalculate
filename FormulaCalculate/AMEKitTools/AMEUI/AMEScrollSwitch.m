//
//  AMEScrollSwitch.m
//  exhibiton_vino
//
//  Created by Vino－lgc on 2017/2/20.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "AMEScrollSwitch.h"

#define VIEW_WIDTH self.frame.size.width
#define VIEW_HEIGHT self.frame.size.height

#define MIDDLE VIEW_WIDTH/2.0+self.titleWidth/2.0

@interface AMEScrollSwitch ()

@property (nonatomic, retain) NSMutableArray<AMEButton *> * titleViews;
@property (nonatomic, strong) UIView * noticeView;


@end

@implementation AMEScrollSwitch

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray *)titleArray tintColor:(UIColor *)tintColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
        if (tintColor) {
           _tintColor = tintColor;
        }else{
            _tintColor = [UIColor colorWithRed:45/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
        }
        self.font = [UIFont fontWithName:SYSTEM_FONT size:13.0f];
        _titleWidth = 30.0f;
        _index = 0;
        _titleArray = titleArray;
        _animated = YES;
        
        [self addSubview:self.noticeView];
    }
    return self;
}
#pragma mark - load & reload;
- (void)reloadViews{
    for (AMEButton * button in self.titleViews) {
        [button removeFromSuperview];
    }
    self.index = 0;
    self.noticeView.frame = CGRectMake(0, VIEW_HEIGHT-3, self.titleWidth, 3);
    self.contentSize = CGSizeMake(SCREEN_WIDTH, VIEW_HEIGHT);
    self.contentOffset = CGPointMake(0, 0);
    
    for (int i=0; i<self.titleArray.count; i++) {
        AMEButton * button = [AMEButton buttonWithType:AMEButtonTypeClean event:^(AMEButton *button){
            self.index = i;
        }];
        button.frame = CGRectMake(i * self.titleWidth, 0, self.titleWidth, VIEW_HEIGHT);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = self.font;
        [button setTitleColor:self.tintColor forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleViews addObject:button];
        [self addSubview:button];
        if ((i+1) * self.titleWidth>SCREEN_WIDTH) {
            self.contentSize = CGSizeMake((i+1) * self.titleWidth, VIEW_HEIGHT);
        }
        if (i == 0) {
            button.selected = YES;
        }
    }
}

#pragma mark - setter & getter
- (NSMutableArray<AMEButton *> *)titleViews{
    if (!_titleViews) {
        _titleViews = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleViews;
}

- (UIView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[UIView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT-3, self.titleWidth, 3)];
        _noticeView.backgroundColor = self.tintColor;
    }
    return _noticeView;
}

- (void)setIndex:(NSInteger)index{
    if (_index != index) {
        _index = index;
        AMEButton * button = self.titleViews[index];
        for (AMEButton * button in self.titleViews) {
            button.selected = NO;
        }
        button.selected = YES;
        if (self.animated) {
            [UIView animateWithDuration:0.4 animations:^{
                self.noticeView.frame = CGRectMake(button.frame.origin.x, VIEW_HEIGHT-3, self.titleWidth, 3);
            }];
        }else{
            self.noticeView.frame = CGRectMake(button.frame.origin.x, VIEW_HEIGHT-3, self.titleWidth, 3);
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(AMEScrollSwitchDidChangeIndex:)]) {
            [self.delegate AMEScrollSwitchDidChangeIndex:self];
        }
        
        //自动滚动
        if (self.contentSize.width>self.frame.size.width) {
            float move = self.contentOffset.x+(button.frame.origin.x-self.contentOffset.x-MIDDLE);
            if (move<0) {
                move=0;
            }else if (move>self.contentSize.width-VIEW_WIDTH){
                move = self.contentSize.width-VIEW_WIDTH;
            }
            [self setContentOffset:CGPointMake(move,0) animated:YES];
        }
    }
}

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    for (AMEButton * button in self.titleViews) {
        [button setTitleColor:tintColor forState:UIControlStateSelected];
    }
    self.noticeView.backgroundColor = tintColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
