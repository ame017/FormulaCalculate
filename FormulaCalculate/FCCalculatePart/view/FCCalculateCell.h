//
//  FCCalculateCell.h
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FCCalculateCell;
@protocol FCCalculateCellDelegate <NSObject>
@optional
- (void)fc_calculateCellDidEndEditing:(FCCalculateCell *)cell;

@end
@interface FCCalculateCell : UITableViewCell <UITextFieldDelegate>


@property (weak, nonatomic) id<FCCalculateCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *varLabel;
@property (weak, nonatomic) IBOutlet UITextField *varTextField;


@end
