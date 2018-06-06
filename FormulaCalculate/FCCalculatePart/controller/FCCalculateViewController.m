//
//  FCCalculateViewController.m
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import "FCCalculateViewController.h"


@interface FCCalculateViewController ()<UITableViewDelegate, UITableViewDataSource, FCCalculateCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@property (nonatomic, strong) NSMutableArray<FCCalculateCellModel *> * varArray;
@property (nonatomic, strong) FCCalculater * calculater;
@property (nonatomic, strong) FCCalculateHeaderView * headView;

@end

@implementation FCCalculateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - buttonClick
- (IBAction)calculateButtonClick:(id)sender {
    for (FCCalculateCellModel * model in self.varArray) {
        if (model.isValuation == NO) {
            [UIAlertController okAlertWithMessage:@"有尚未赋值的变量" okEvent:^{
                
            } isShow:YES];
            return;
        }
    }
    NSString * calculateString = [self.calculater fc_makeCalculateString:self.varArray formula:self.formulaString];
    self.headView.nowEquation = calculateString;
    double ans = [self.calculater fc_calculateWithString:calculateString];
    self.headView.answer = [self.calculater fc_doubleToString:ans];
}
#pragma mark - cellDelegate
- (void)fc_calculateCellDidEndEditing:(FCCalculateCell *)cell{
    if (![cell.varTextField.text ame_isPureFloat]) {
        [SVProgressHUD showErrorWithStatus:@"输入有误"];
        cell.varTextField.text = @"";
    }else{
        NSInteger row = [self.mainTable indexPathForCell:cell].row;
        self.varArray[row].varValue = cell.varTextField.text.doubleValue;
        self.varArray[row].isValuation = YES;
    }
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.varArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FCCalculateCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    cell.varLabel.text = self.varArray[indexPath.row].varName;
    cell.varTextField.text = [self.calculater fc_doubleToString:self.varArray[indexPath.row].varValue];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}

#pragma mark - getter & setter
- (NSMutableArray<FCCalculateCellModel *> *)varArray{
    if(!_varArray){
        _varArray = ({
            NSMutableArray * object = [self.calculater fc_splitVariableToArrayWithString:self.formulaString];
            NSLog(@"%@",object);
            object;
       });
    }
    return _varArray;
}

- (FCCalculater *)calculater{
    if(!_calculater){
        _calculater = ({
            FCCalculater * object = [FCCalculater share];
            object;
       });
    }
    return _calculater;
}

- (FCCalculateHeaderView *)headView{
    if(!_headView){
        _headView = ({
//            UINib *nib = [UINib nibWithNibName:@"FCCalculateHeaderView" bundle:nil];
//            FCCalculateHeaderView * object = [[nib instantiateWithOwner:nil options:nil]firstObject];
            FCCalculateHeaderView * object = [[FCCalculateHeaderView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            object.formula = self.formulaString;
            object;
       });
    }
    return _headView;
}
@end
