//
//  AMETextField.m
//  TJSWorking
//
//  Created by ame on 2017/11/17.
//  Copyright © 2017年 tejisong. All rights reserved.
//

#import "AMETextField.h"

#define ameProgressShow(FORMAT,...) if(firstResponder){\
[self becomeFirstResponder];\
}\
[SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:FORMAT, ##__VA_ARGS__]];\
return NO


@interface AMETextField ()
@property (nonatomic, assign) NSInteger textLastLength;

@end

@implementation AMETextField

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)checkTextEnableWithFirstResponder:(BOOL)firstResponder{
    if (!self.canEmpty && kStringIsEmpty(self.text)) {
        ameProgressShow(@"%@不能为空",self.fieldName);
    }
    if (!kStringIsEmpty(self.text) && ((self.contentType == AMETextFieldContentTypeInterger && ![self.text ame_isPureInt])||(self.contentType == AMETextFieldContentTypeFloat && ![self.text ame_isPureFloat]))) {
        ameProgressShow(@"%@的格式不正确",self.fieldName);
    }
    if (!kStringIsEmpty(self.text) && self.text.length < self.minLength) {
        ameProgressShow(@"%@的长度最少%ld",self.fieldName,self.minLength);
    }
    if ([self.text ame_lengthConsiderLetter] > self.maxLength*2 && self.maxLength && self.contentType == AMETextFieldContentTypeNormal) {
        ameProgressShow(@"%@的长度最大%ld",self.fieldName,self.maxLength);
    }
    if (self.text.length > self.maxLength && self.maxLength && self.contentType != AMETextFieldContentTypeNormal) {
        ameProgressShow(@"%@的长度最大%ld",self.fieldName,self.maxLength);
    }
    if (self.text.doubleValue > self.maxNum && self.maxNum) {
        ameProgressShow(@"%@的值过大",self.fieldName);
    }
    if (!kStringIsEmpty(self.text) && self.text.doubleValue < self.minNum) {
        ameProgressShow(@"%@的值过小",self.fieldName);
    }
    if (self.contentType == AMETextFieldContentTypeDate) {
        BOOL isRight = YES;
        NSString * time = self.text;
        if (!kStringIsEmpty(time)) {
            NSArray<NSString *> * array = [time componentsSeparatedByString:@"-"];
            if (array.count != 3) {
                isRight = NO;
            }else if(![array[0] ame_isPureInt] || array[0].length != 4 || array[0].integerValue <2017){
                isRight = NO;
            }else if (![array[1] ame_isPureInt] || array[1].length != 2 || array[1].integerValue >12 || array[1].integerValue <=0)
                isRight = NO;
            else if (![array[2] ame_isPureInt] || array[2].length != 2 || array[1].integerValue >31 || array[1].integerValue <=0){
                isRight = NO;
            }
        }
        if (!isRight) {
            ameProgressShow(@"取货时间格式不正确\n格式为xxxx-xx-xx");
        }
    }
    return YES;
}

#pragma mark - delegate
- (void)textFieldDidChange{
    if (kStringIsEmpty(self.text)) {
        return;
    }
    switch (self.contentType) {
        case AMETextFieldContentTypeNormal:{
            if (self.maxLength) {
                NSInteger maxLength = self.maxLength*2;
                //判断输入法是中文还是英文
                BOOL isChinese = [AMETool inputIsChinese];
                if (isChinese) {
                    UITextRange *selectedRange = [self markedTextRange];
                    //获取高亮部分
                    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
                    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                    if (!position) {
                        NSInteger textcount = [self.text ame_lengthConsiderLetter];
                        //                NSLog(@"[self.text ame_lengthConsiderLetter] = %ld",[self.text ame_lengthConsiderLetter]);
                        //                NSLog(@"maxLength = %ld",maxLength);
                        if ([self.text ame_lengthConsiderLetter] >= maxLength) {
                            NSInteger chineseCount = [[NSString stringWithFormat:@"%lu",textcount - self.text.length] intValue];
                            NSInteger indexCount = (maxLength/2 -(textcount - 2*chineseCount)/2 )+ (textcount - 2*chineseCount);
                            //                    NSLog(@"chineseCount = %ld",chineseCount);
                            //                    NSLog(@"indexCount = %ld",indexCount);
                            self.text = [self.text substringToIndex:indexCount];
                        }
                    }
                }else{
                    if (self.text.length >= maxLength) {
                        self.text = [self.text substringToIndex:maxLength];
                    }
                }
            }
        }break;
        case AMETextFieldContentTypeDate:{
            if (self.text.length > self.maxLength && self.maxLength) {
                self.text = [self.text substringToIndex:self.maxLength];
            }
            if (self.text.length<=4 || (self.text.length >5 && self.text.length <=7) || (self.text.length>8 && self.text.length<=10)) {
//                NSLog(@"%ld-%ld",self.textLastLength,self.text.length);
                if (![[self.text substringFromIndex:self.text.length-1] ame_isPureInt]) {
                    self.text = [self.text substringToIndex:self.text.length-1];
                }else if ((self.text.length == 4 || self.text.length == 7) && self.textLastLength < self.text.length){
                    self.text = [NSString stringWithFormat:@"%@-",self.text];
                }
            }
        }break;
        case AMETextFieldContentTypeFloat:{
            if (![self.text ame_isPureFloat]) {
                self.text = [self.text substringToIndex:self.text.length-1];
            }
            if (self.text.floatValue > self.maxNum && self.maxNum) {
                self.text = [NSString stringWithFormat:@"%.2f",self.maxNum];
            }
//            if (self.text.floatValue < self.minNum){
//                self.text = [NSString stringWithFormat:@"%.2f",self.minNum];
//            }
            NSArray<NSString *> * array = [self.text componentsSeparatedByString:@"."];
            if (array.count == 2 && array[1].length > self.decimalLenth && self.decimalLenth) {
                self.text = [NSString stringWithFormat:@"%@.%@",array[0],[array[1] substringToIndex:self.decimalLenth]];
            }
        }break;
        case AMETextFieldContentTypeInterger:{
            if (self.text.length > self.maxLength && self.maxLength) {
                self.text = [self.text substringToIndex:self.maxLength];
            }
            if (![self.text ame_isPureInt]) {
                self.text = [self.text substringToIndex:self.text.length-1];
            }
            if (self.text.floatValue > self.maxNum && self.maxNum) {
                self.text = kIntegerToString((NSInteger)self.maxNum);
            }
//            if (self.text.floatValue < self.minNum){
//                self.text = kIntegerToString((NSInteger)self.minNum);
//            }
        }break;
            
        default:
            break;
    }
    self.textLastLength = self.text.length;
}

#pragma mark - getter & setter

- (void)setContentType:(AMETextFieldContentType)contentType{
    _contentType = contentType;
    switch (contentType) {
        case AMETextFieldContentTypeNormal:{
//            self.keyboardType = UIKeyboardTypeDefault;
        }break;
        case AMETextFieldContentTypeDate:{
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.maxLength = 10;
        }break;
        case AMETextFieldContentTypeFloat:{
            self.decimalLenth = 2;
            self.keyboardType = UIKeyboardTypeDecimalPad;
        }break;
        case AMETextFieldContentTypeInterger:{
            self.keyboardType = UIKeyboardTypeNumberPad;
        }break;
            
        default:
            break;
    }
}


- (NSMutableDictionary *)userInfo{
    if(!_userInfo){
        _userInfo = ({
            NSMutableDictionary * object = [[NSMutableDictionary alloc]init];
            object;
       });
    }
    return _userInfo;
}
@end
