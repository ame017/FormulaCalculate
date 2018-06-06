//
//  AMETextView.m
//  exhibiton_vino
//
//  Created by Vino－lgc on 16/10/19.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "AMETextView.h"
#define ameProgressShow(FORMAT,...) if(firstResponder){\
[self becomeFirstResponder];\
}\
[SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:FORMAT, ##__VA_ARGS__]];\
return NO

@interface AMETextView()<UITextViewDelegate>

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation AMETextView



- (void)awakeFromNib{
    [super awakeFromNib];
//    UILabel *placeholderLabel = [[UILabel alloc] init];
//    placeholderLabel.backgroundColor = [UIColor clearColor];
//    placeholderLabel.numberOfLines = 0;
//    [self addSubview:placeholderLabel];
//    self.placeholderLabel = placeholderLabel;
//    self.placeholderColor = [UIColor lightGrayColor];
    self.font = [UIFont systemFontOfSize:15];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    self.delegate = self;
    self.canCangeLine = YES;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor clearColor];
//        UILabel *placeholderLabel = [[UILabel alloc] init];
//        placeholderLabel.backgroundColor = [UIColor clearColor];
//        placeholderLabel.numberOfLines = 0;
//        [self addSubview:placeholderLabel];
//        self.placeholderLabel = placeholderLabel;
//        self.placeholderColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:15];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        self.delegate = self;
        self.canCangeLine = YES;
    }
    return self;
}

#pragma mark - delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (!self.canCangeLine) {
        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
            //在这里做你响应return键的代码
            if (self.returnKeyEvent) {
                self.returnKeyEvent(self);
            }
//            if (kDelegateEnable(self.delegate, @selector(returnButtonDidClick:))) {
//                [self.delegate returnButtonDidClick:self];
//            }
            return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        }
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@"\n"]) {
        textView.text = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
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
                textView.text = [textView.text substringToIndex:maxLength];
            }
        }
    }
}
#pragma mark - check
- (BOOL)checkTextEnableWithFirstResponder:(BOOL)firstResponder{
    if (!self.canEmpty && kStringIsEmpty(self.text)) {
        ameProgressShow(@"%@不能为空",self.viewName);
    }
    if (self.text.length < self.minLength) {
        ameProgressShow(@"%@的长度最少%ld",self.viewName,self.minLength);
    }
    if ([self.text ame_lengthConsiderLetter] > self.maxLength*2 && self.maxLength) {
        ameProgressShow(@"%@的长度最大%ld",self.viewName,self.minLength);
    }
    return YES;
}
//#pragma placeholder
//- (void)textDidChange{
//
//    self.placeholderLabel.hidden = self.hasText;
//
//}
//
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    CGSize maxSize = CGSizeMake(self.placeholderLabel.frame.size.width, MAXFLOAT);
//    float height = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeholderLabel.font} context:nil].size.height;
//    self.placeholderLabel.frame = CGRectMake(5, 8, self.frame.size.width - 10, height);
//
//}
//
//-(void)setPlaceholder:(NSString *)placeholder{
//    _placeholder = placeholder;
//    self.placeholderLabel.text = placeholder;
//    [self setNeedsLayout];
//}
//
//-(void)setPlaceholderColor:(UIColor *)placeholderColor{
//    _placeholderColor = placeholderColor;
//    self.placeholderLabel.textColor = placeholderColor;
//}
//
//- (void)setFont:(UIFont *)font{
//    [super setFont:font];
//    self.placeholderLabel.font = font;
//    [self setNeedsLayout];
//}
//
//- (void)setText:(NSString *)text{
//    [super setText:text];
//    [self textDidChange];
//}
//
//- (void)setAttributedText:(NSAttributedString *)attributedText{
//    [super setAttributedText:attributedText];
//    [self textDidChange];
//}
//
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
//
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
