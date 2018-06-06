//
//  FCCalculateHeaderView.m
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import "FCCalculateHeaderView.h"
#import "UIView+Xib.h"
@interface FCCalculateHeaderView()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *formulaLabel;
@property (weak, nonatomic) IBOutlet UILabel *equationLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end

@implementation FCCalculateHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupSelfNameXibOnSelf];
    self.equationLabel.text = @" ";
    self.answerLabel.text   = @" ";
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setupSelfNameXibOnSelf];
    self.equationLabel.text = @" ";
    self.answerLabel.text   = @" ";
    return self;
}

- (void)setAnswer:(NSString *)answer{
    self.answerLabel.text = answer;
}
- (void)setFormula:(NSString *)formula{
    self.formulaLabel.text = formula;
}
- (void)setNowEquation:(NSString *)nowEquation{
    self.equationLabel.text = nowEquation;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
