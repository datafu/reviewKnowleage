//
//  FSPTextField.h
//  reviewKnowleage
//
//  Created by fushp on 2018/10/26.
//  Copyright © 2018 fushp. All rights reserved.
//

#import "QMUITextField.h"



@interface FSPTextField : QMUITextField

/** 右边的按钮  当存在leftview的时候 需要自定义 避免覆盖*/
@property(nonatomic, strong) UIView *normalRightView;

/** 初始化必要的参数信息*/
- (void)didInitialize;

@end


