//
//  UITableViewCell+Maker.h
//  TJSWorking
//
//  Created by ame on 2017/10/23.
//  Copyright © 2017年 tejisong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Maker)

/**
 生成一个cell

 @param tableView 重用
 @param identity 重用
 @param allocCompletion alloc完成后
 */
+ (UITableViewCell *)ame_makeCellWithTableView:(UITableView *)tableView
                                         style:(UITableViewCellStyle)cellStyle
                         identity:(NSString *)identity
                  allocCompletion:(void(^)(UITableViewCell * makeCell))allocCompletion;

+ (UITableViewCell *)ame_makeCellWithTableView:(UITableView *)tableView
                                       nibName:(NSString *)nibName
                                      identity:(NSString *)identity
                               allocCompletion:(void(^)(UITableViewCell * makeCell))allocCompletion;

@end
