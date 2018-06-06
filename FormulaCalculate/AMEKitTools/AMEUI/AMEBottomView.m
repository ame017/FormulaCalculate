//
//  AMEBottomView.m
//  exhibiton_vino
//
//  Created by Vino－lgc on 2016/12/20.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "AMEBottomView.h"

@interface AMEBottomView ()

@property (nonatomic, assign) CGRect startLocation;
@property (nonatomic, assign) CGRect overLocation;

@end

@implementation AMEBottomView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.contentView = [UIView new];
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:self.contentView];
        self.userInfo = [NSDictionary dictionary];
        self.backgroundColor = [UIColor whiteColor];
        self.originalFrame = CGRectMake(10, SCREEN_HEIGHT+10, self.frame.size.width, self.frame.size.height);
        self.showPoint = CGPointMake(10, SCREEN_HEIGHT-self.frame.size.height-10);
        self.duration = 0.5;
        _isShow = NO;
        self.isAnimated = YES;
        self.powerful = NO;
        self.showWay = AMEBottomViewShowWayMove;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView = [UIView new];
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:self.contentView];
        self.userInfo = [NSDictionary dictionary];
        self.backgroundColor = [UIColor whiteColor];
        self.originalFrame = frame;
        self.showPoint = CGPointMake(10, SCREEN_HEIGHT-self.frame.size.height-10);
        self.duration = 0.5;
        _isShow = NO;
        self.isAnimated = YES;
        self.powerful = NO;
        self.showWay = AMEBottomViewShowWayMove;
    }
    return self;
}

- (void)setOriginalFrame:(CGRect)originalFrame{
    _originalFrame = originalFrame;
    self.frame = originalFrame;
    self.startLocation = originalFrame;
}

- (void)setContentView:(UIView *)contentView{
    [_contentView removeFromSuperview];
    _contentView = contentView;
    _contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_contentView];
}

- (void)setShowWay:(AMEBottomViewShowWay)showWay{
    _showWay = showWay;
    self.frame = _originalFrame;
}

- (void)setShowPoint:(CGPoint)showPoint{
    _showPoint = showPoint;
    
    self.overLocation = CGRectMake(self.showPoint.x, self.showPoint.y, self.frame.size.width, self.frame.size.height);
}

- (void)show{
    if (self.isAnimated) {
        switch (self.showWay) {
            case AMEBottomViewShowWayMove:{
                if (self.powerful) {
                    [UIView animateWithDuration:self.duration*0.7 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                        self.frame = CGRectMake(self.overLocation.origin.x, self.overLocation.origin.y-10,self.frame.size.width, self.frame.size.height);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:self.duration*0.15 animations:^{
                            self.frame = CGRectMake(self.overLocation.origin.x, self.overLocation.origin.y+8,self.frame.size.width, self.frame.size.height);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:self.duration*0.15 animations:^{
                                self.frame = self.frame = self.overLocation;
                            } completion:^(BOOL finished) {
                                [self.delegate animationDone:YES];
                            }];
                        }];
                    }];
                }else{
                    [UIView animateWithDuration:self.duration animations:^{
                        self.frame = self.overLocation;
                    } completion:^(BOOL finished) {
                        [self.delegate animationDone:YES];
                    }];
                }
            }
                break;
            case AMEBottomViewShowWayAlpha:{
                [UIView animateWithDuration:self.duration animations:^{
                    self.alpha = 1;
                } completion:^(BOOL finished) {
                    [self.delegate animationDone:YES];
                }];
            }
                break;
        }
    }else{
        switch (self.showWay) {
            case AMEBottomViewShowWayMove:{
                self.frame = self.overLocation;
            }
                break;
            case AMEBottomViewShowWayAlpha:{
                self.alpha = 1;
            }
                break;
        }
    }
    _isShow = YES;
}

- (void)dismiss{
    if (self.isAnimated) {
        switch (self.showWay) {
            case AMEBottomViewShowWayMove:{
                [UIView animateWithDuration:self.duration animations:^{
                    self.frame = self.startLocation;
                } completion:^(BOOL finished) {
                    [self.delegate animationDone:NO];
                }];
            }
                break;
            case AMEBottomViewShowWayAlpha:{
                [UIView animateWithDuration:self.duration animations:^{
                    self.alpha = 0;
                } completion:^(BOOL finished) {
                    [self.delegate animationDone:NO];
                }];
            }
                break;
        }
    }else{
        switch (self.showWay) {
            case AMEBottomViewShowWayMove:{
                self.frame = self.startLocation;
            }
                break;
            case AMEBottomViewShowWayAlpha:{
                self.alpha = 0;
            }
                break;
        }
    }
    _isShow = NO;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
