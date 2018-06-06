//
//  AMESearchBar.m
//  TJSWorking
//
//  Created by ame on 2018/3/9.
//  Copyright © 2018年 tejisong. All rights reserved.
//

#import "AMENavigationSearchBar.h"
#undef macroIOS11_ORLATER
#define IOS11_ORLATER ([[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending )
@interface AMENavigationSearchBar()

@property (nonatomic, assign) CGRect fieldFrame;

@end
@implementation AMENavigationSearchBar{
    UITextField * _searchField;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setUpView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame iOS11FieldFrame:(CGRect)fieldFrame{
    self = [super initWithFrame:frame];
    if (self) {
        self.fieldFrame = fieldFrame;
        [self _setUpView];
    }
    return self;
}
#pragma mark - Private
- (void)_setUpView{
    // iOS11版本以后 高度限制为44
    if (IOS11_ORLATER) {
        [self.heightAnchor constraintEqualToConstant:44].active = YES;
        self.searchTextPositionAdjustment = (UIOffset){10, 0}; // 光标偏移量
    }
}

- (void)_hookSearchBar{
    // 遍历子视图，获取输入UITextFiled
    if (!_searchField) {
        NSArray *subviewArr = self.subviews;
        for(int i = 0; i < subviewArr.count ; i++) {
            UIView *viewSub = [subviewArr objectAtIndex:i];
            NSArray *arrSub = viewSub.subviews;
            for (int j = 0; j < arrSub.count ; j ++) {
                id tempId = [arrSub objectAtIndex:j];
                if([tempId isKindOfClass:[UITextField class]]) {
                    _searchField = (UITextField *)tempId;
                }
            }
        }
    }
    
    if (_searchField) {
        //自定义UISearchBar
        UITextField *searchField = _searchField;
        if (IOS11_ORLATER) {
            searchField.frame = self.fieldFrame;
        }else{
            searchField.frame = CGRectMake(0, self.fieldFrame.origin.y, self.fieldFrame.size.width, self.fieldFrame.size.height);
        }
    }
}
#pragma mark - Layout
-(void) layoutSubviews{
    [super layoutSubviews];
    [self _hookSearchBar];
}


@end
