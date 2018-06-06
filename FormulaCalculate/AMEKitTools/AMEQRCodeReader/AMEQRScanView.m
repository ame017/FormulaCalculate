//
//  AMEQRScanView.m
//  TJSWorking
//
//  Created by ame on 2017/12/3.
//  Copyright © 2017年 tejisong. All rights reserved.
//

#import "AMEQRScanView.h"

@interface AMEQRScanView()

@end

@implementation AMEQRScanView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImageView];
        [self addSubview:self.scanImageView];
        self.animationInterval = 1.5;
        [self scanAnimationStart];
    }
    return self;
}

- (void)scanAnimationStart{
    self.scanImageView.frame = CGRectMake(0, 0, self.frame.size.width, 2);
    [UIView animateWithDuration:self.animationInterval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.scanImageView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 2);
    } completion:^(BOOL finished) {
         [self scanAnimationStart];
    }];
}

#pragma mark - getter & setter
- (UIImageView *)backImageView{
    if(!_backImageView){
        _backImageView = ({
            UIImageView * object = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            object.image = [UIImage imageNamed:@"scan_frame"];
            object;
       });
    }
    return _backImageView;
}

- (UIImageView *)scanImageView{
    if(!_scanImageView){
        _scanImageView = ({
            UIImageView * object = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
            object.image = [UIImage imageNamed:@"scan_line"];
            object;
       });
    }
    return _scanImageView;
}
@end
