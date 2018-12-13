//
//  FSPLoginViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPLoginViewController.h"
#import "FSPEditTextField.h"
#import "FSPTextField.h"
@interface FSPLoginViewController ()
@property(nonatomic, strong) FSPTextField *userPassword;
@property (strong, nonatomic) IBOutlet FSPCountdownButton *countDownBtn;
@property (weak, nonatomic) IBOutlet FSPEditTextField *userEditView;

@end

@implementation FSPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
}
- (void)initSubviews {
    [super initSubviews];
    self.userPassword = [[FSPTextField alloc] init];
    [self.view addSubview:self.userPassword];
    QMUIButton * btn =  [QDUIHelper generateDarkFilledButtonWithW_H:40 hight:40];
    btn.titleLabel.text = @"我是按钮";
    self.userPassword.normalRightView = btn;
    self.userPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userPassword.placeholder = @"请输入手机号获取用户名";
    
    self.userEditView.normalRightView = self.countDownBtn;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat y = self.qmui_navigationBarMaxYInViewCoordinator;
    self.userPassword.frame = CGRectMake(15, y+ 20, 200, 60);
    
    
}

@end
