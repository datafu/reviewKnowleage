//
//  FSPEditTextFieldWithSmsCode.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//  右边是验证码按钮


#import "FSPEditTextFieldWithSmsCode.h"
#import "FSPCountdownButton.h"

@interface FSPEditTextFieldWithSmsCode()
// 验证码按钮
@property(nonatomic, strong) FSPCountdownButton *countdownButton;
@end



@implementation FSPEditTextFieldWithSmsCode


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self didEditTextFieldWithSmsCodeInitialize];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didEditTextFieldWithSmsCodeInitialize];
    }
    return self;
}
- (void)didEditTextFieldWithSmsCodeInitialize {
    FSPCountdownButton * coutdown = [QDUIHelper generateCountdownButton:100 hight:27];
    self.normalRightView = coutdown;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}






@end
