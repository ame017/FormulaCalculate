//
//  UITableViewCell+Maker.m
//  TJSWorking
//
//  Created by ame on 2017/10/23.
//  Copyright © 2017年 tejisong. All rights reserved.
//

#import "UITableViewCell+Maker.h"

@implementation UITableViewCell (Maker)
+ (UITableViewCell *)ame_makeCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle identity:(NSString *)identity allocCompletion:(void(^)(UITableViewCell * makeCell))allocCompletion{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[self alloc]initWithStyle:cellStyle reuseIdentifier:identity];
        if (allocCompletion) {
            allocCompletion(cell);
        }
    }
    return cell;
}

+ (UITableViewCell *)ame_makeCellWithTableView:(UITableView *)tableView
                                       nibName:(NSString *)nibName
                                      identity:(NSString *)identity
                               allocCompletion:(void(^)(UITableViewCell * makeCell))allocCompletion{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil].lastObject;
        if (allocCompletion) {
            allocCompletion(cell);
        }
    }
    return cell;
}
@end
