//
//  QDButtonViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/17.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "QDButtonViewController.h"
#import "QDNormalButtonViewController.h"
#import "QDLinkButtonViewController.h"
#import "QDGhostButtonViewController.h"
#import "QDNavigationButtonViewController.h"
#import "QDToolBarButtonViewController.h"
#import "SettingViewController.h"
#import "FFDialogViewController.h"
#import "FFDialogTextFieldViewController.h"

@interface QDButtonViewController ()

@end

@implementation QDButtonViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - private methods
- (void)initDataSource{
    self.dataSource = @[@"QMUIButton",
                    @"QMUILinkButton",
                    @"QMUIChostButton",
                    @"QMUIFillButton",
                    @"QMUINavigationButton",
                    @"QMUIToobarButton",
                    @"基本信息",
                    @"FFDialogViewController",
                        @"FFDialogTextFieldViewController"
                        ];
    
}

- (void)didSelectCellWithTitle:(NSString *)title {
    UIViewController *viewController = nil;
    if ([title isEqualToString:@"QMUIButton"]) {
        viewController = [[ QDNormalButtonViewController alloc] init];
    }else if ([title isEqualToString:@"QMUILinkButton"]) {
        viewController = [[ QDLinkButtonViewController alloc] init];
    }else if ([title isEqualToString:@"QMUIChostButton"]) {
        viewController = [[ QDGhostButtonViewController alloc] init];
    }else if ([title isEqualToString:@"QMUINavigationButton"]) {
        viewController = [[ QDNavigationButtonViewController alloc] init];
    }else if ([title isEqualToString:@"QMUIToobarButton"]) {
        viewController = [[ QDToolBarButtonViewController alloc] init];
    }else if ([title isEqualToString:@"基本信息"]) {
        viewController = [[ SettingViewController alloc] init];
    }else if ([title isEqualToString:@"FFDialogViewController"]) {
        [self showNormalDialogViewController];
        return ;
    }else if ([title isEqualToString:@"FFDialogTextFieldViewController"]) {
        [self showNormalTextFieldDialogViewController];
        return ;
    }
    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];

}

- (void)showNormalDialogViewController {
//    FFDialogViewController *dialogViewController = [[FFDialogViewController alloc] init];
//    dialogViewController.title = @"提示";
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
//    contentView.backgroundColor = UIColorWhite;
//    UILabel *label = [[UILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:Color_15152D_alpha(0.7)];
//    label.text = @"清除缓存？";
//    [label sizeToFit];
//    label.center = CGPointMake(CGRectGetWidth(contentView.bounds) / 2.0, CGRectGetHeight(contentView.bounds) / 2.0);
//    [contentView addSubview:label];
//    dialogViewController.contentView = contentView;
//    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
//    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
//        [aDialogViewController hide];
//    }];
    FFDialogViewController *dialogViewController = [QDUIHelper showNormalDialogViewController:@"提示" contenText:@"清除缓存？"];
    [dialogViewController show];
}

- (void)showNormalTextFieldDialogViewController {
    //创建一个短信验证码
    QMUIDialogTextFieldViewController *dialogViewController = [QDUIHelper showNormalTextFieldDialogViewController:@"请输入短信验证码" headTitleWithTextField:@"检测到你的账户在一个新的设备上登录,请输入短信验证码重新登录" placeholderText:@"验证码已发送,请注意查收"];
    [dialogViewController show];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
