//
//  FCHomeViewController.m
//  FormulaCalculate
//
//  Created by ame on 2018/6/6.
//  Copyright © 2018年 ame017. All rights reserved.
//

#import "FCHomeViewController.h"

@interface FCHomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *formulaTextField;

@end

@implementation FCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)insertButtonClick:(UIButton *)sender {
    self.formulaTextField.text = [NSString stringWithFormat:@"%@%@",self.formulaTextField.text,[sender titleForState:UIControlStateNormal]];
}
- (IBAction)deleteButtonClick:(UIButton *)sender {
    if (self.formulaTextField.text.length == 0) {
        return;
    }
    self.formulaTextField.text = [self.formulaTextField.text substringWithRange:NSMakeRange(0, self.formulaTextField.text.length-1)];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController.restorationIdentifier isEqualToString:@"calculate"]) {
        FCCalculateViewController * vc = (FCCalculateViewController *)segue.destinationViewController;
        vc.formulaString = self.formulaTextField.text;
    }
}


@end
