//
//  FSPTextFieldViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/15.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPTextFieldViewController.h"
#import "FSPTextField.h"
#import "FSPUITextFieldInputJuageTools.h"
@interface FSPTextFieldViewController ()<QMUITextFieldDelegate>
@property(nonatomic, strong) FSPTextField *textField;
@property(nonatomic, strong) UILabel *tipsLabel;
@end

@implementation FSPTextFieldViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didInitialize {
    [super didInitialize];
    // https://github.com/QMUI/QMUI_iOS/issues/114
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)initSubviews {
    [super initSubviews];
    
    _textField = [[FSPTextField alloc] init];
    self.textField.delegate = self;
    self.textField.maximumTextLength = 10;
    self.textField.placeholder = @"请输入文字";
    self.textField.font = UIFontMake(16);
    self.textField.layer.cornerRadius = 2;
    self.textField.layer.borderColor = UIColorSeparator.CGColor;
    self.textField.layer.borderWidth = PixelOne;
    self.textField.textInsets = UIEdgeInsetsMake(0, 10, 0, 40);
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.textField];
    self.textField.clearButtonPositionAdjustment = UIOffsetMake(-40, 0);
    self.tipsLabel = [[UILabel alloc] init];
    self.tipsLabel.attributedText = [[NSAttributedString alloc] initWithString:@"支持：\n1. 自定义 placeholder 颜色；\n2. 修改 clearButton 的图片和布局位置；\n3. 调整输入框与文字之间的间距；\n4. 限制可输入的最大文字长度（可试试输入 emoji、从中文输入法候选词输入等）；\n5. 计算文字长度时区分中英文。" attributes:@{NSFontAttributeName: UIFontMake(12), NSForegroundColorAttributeName: UIColorGray6, NSParagraphStyleAttributeName: [NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:20]}];
    self.tipsLabel.numberOfLines = 0;
    [self.view addSubview:self.tipsLabel];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIEdgeInsets padding = UIEdgeInsetsMake(self.qmui_navigationBarMaxYInViewCoordinator + 16, 16, 16, 16);
    CGFloat contentWidth = CGRectGetWidth(self.view.bounds) - UIEdgeInsetsGetHorizontalValue(padding);
    self.textField.frame = CGRectMake(padding.left, padding.top, contentWidth, 40);
    
    self.tipsLabel.frame = CGRectFlatMake(padding.left, CGRectGetMaxY(self.textField.frame) + 8, contentWidth, QMUIViewSelfSizingHeight);
}

#pragma mark - <QMUITextFieldDelegate>

- (void)textField:(QMUITextField *)textField didPreventTextChangeInRange:(NSRange)range replacementString:(NSString *)replacementString {
    [QMUITips showWithText:[NSString stringWithFormat:@"文字不能超过 %@ 个字符", @(textField.maximumTextLength)] inView:self.view hideAfterDelay:2.0];
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//        ///密码限制只能输入数字和字母
//    return  [FSPUITextFieldInputJuageTools juageNumberOrCharacter:string];
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
