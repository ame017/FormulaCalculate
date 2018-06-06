//
//  UIView+Sub.m
//  TJSWorking
//
//  Created by ame on 2018/3/9.
//  Copyright © 2018年 tejisong. All rights reserved.
//

#import "UIView+Sub.h"

@implementation UIView (Sub)

- (UIView*)subViewOfClassName:(NSString*)className{
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}

@end
