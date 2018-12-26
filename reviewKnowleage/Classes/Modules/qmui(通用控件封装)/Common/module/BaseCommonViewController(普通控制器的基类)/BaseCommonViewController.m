//
//  BaseCommonViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/17.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "BaseCommonViewController.h"

@interface BaseCommonViewController ()

@end

@implementation BaseCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击空白区域 隐藏键盘
- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
    return YES;
}


#pragma mark - life cycle

#pragma mark - network request

#pragma mark - private methods

#pragma mark - setting and getting


@end

