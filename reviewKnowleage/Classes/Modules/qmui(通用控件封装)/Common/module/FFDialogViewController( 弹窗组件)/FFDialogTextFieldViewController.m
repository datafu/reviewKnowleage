//
//  FFDialogTextFieldViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/23.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FFDialogTextFieldViewController.h"
#import "UIColor+FF.h"
#import "UIButton+FF.h"

static CGFloat const kleft = 13;

@interface FFDialogTextFieldViewController ()

@end

@implementation FFDialogTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didInitialize {
    [super didInitialize];
    self.footerViewHeight = self.footerViewHeight+20;
    self.buttonBackgroundColor = UIColorMakeWithHex(@"80bfff");
    self.headerViewBackgroundColor = [UIColor whiteColor];
    self.buttonTitleAttributes =@{NSForegroundColorAttributeName: UIColorWhite};
}
- (void)addCancelButtonWithText:(NSString *)buttonText block:(void (^)(__kindof QMUIDialogViewController *aDialogViewController))block {
    [super addCancelButtonWithText:buttonText block:block];
    self.cancelButton.layer.cornerRadius = 4;
}

- (void)addSubmitButtonWithText:(NSString *)buttonText block:(void (^)(__kindof QMUIDialogViewController *dialogViewController))block {
    [super addSubmitButtonWithText:buttonText block:block];
    self.submitButton.layer.cornerRadius = 4;
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //重新设置按钮的布局
    BOOL isFooterViewShowing = self.footerView && !self.footerView.hidden;
    if (isFooterViewShowing) {
        CGRect cancelRect = self.cancelButton.frame;
        self.cancelButton.backgroundColor = [UIColor whiteColor];
        self.cancelButton.frame = CGRectMake(kleft, 0, (self.cancelButton.frame.size.width - 2*kleft), cancelRect.size.height -20);
        [self.cancelButton  fillbBorderColor:Color_15152D_alpha(0.5) borderColor:Color_15152D_alpha(0.2) borderWidth:1 cornerRadius:6];
        self.submitButton.frame = CGRectMake(CGRectGetMinX(self.submitButton.frame) + kleft, 0, (self.submitButton.frame.size.width - 2*kleft), self.submitButton.frame.size.height -20);
        self.footerViewSeparatorLayer.hidden = YES;
        self.buttonSeparatorLayer.hidden = YES;
    }
    // 全部基于 contentView 布局即可
}


@end
