//
//  FCCalculateCell.m
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import "FCCalculateCell.h"

@implementation FCCalculateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (kDelegateEnable(self.delegate, @selector(fc_calculateCellDidEndEditing:))) {
        [self.delegate fc_calculateCellDidEndEditing:self];
    }
}


@end
