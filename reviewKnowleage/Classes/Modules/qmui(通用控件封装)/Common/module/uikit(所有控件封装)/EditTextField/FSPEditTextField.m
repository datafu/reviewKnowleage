//
//  FSPEditTextField.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPEditTextField.h"
#import "FSPTextField.h"
@interface FSPEditTextField()
@property(nonatomic, strong) FSPTextField *textfield;
@property(nonatomic, strong) UIImageView *leftImageView;

@end

@implementation FSPEditTextField


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self didInitialize];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    
    self.textfield = [[FSPTextField alloc] init];
    [self addSubview:self.textfield];
    self.textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textfield.borderStyle = UITextBorderStyleNone;
    self.qmui_borderPosition = QMUIViewBorderPositionBottom;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //如果存在左图片
    CGFloat leftImageviewWidth = CGRectGetWidth(_leftImageView.frame);
    if (leftImageviewWidth > 0) {
        _leftImageView.frame = CGRectSetY(self.leftImageView.frame, CGRectGetMinYVerticallyCenterInParentRect(self.frame,self.leftImageView.frame));
    
    }
    //如果存在右图片 居中即可
    CGFloat rifhtWidth = CGRectGetWidth(_normalRightView.frame);
    if (rifhtWidth > 0) {
         _normalRightView.frame = CGRectSetXY(_normalRightView.frame, CGRectGetWidth(self.frame) - CGRectGetWidth(_normalRightView.frame), CGRectGetMinYVerticallyCenterInParentRect(self.frame,_normalRightView.frame));
    }
    self.textfield.frame = CGRectMake( leftImageviewWidth + 10 , 0,CGRectGetWidth(self.frame) - leftImageviewWidth - rifhtWidth -20 , CGRectGetHeight(self.frame));
}

#pragma mark -  private methods


#pragma mark - setting and getting

- (void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    [self.leftImageView removeFromSuperview];
    self.leftImageView = [[UIImageView alloc] initWithImage:leftImage];
    [self addSubview:self.leftImageView];
    [self setNeedsLayout];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textfield.placeholder = _placeholder;
}


- (void)setNormalRightView:(UIView *)normalRightView {
    [_normalRightView removeFromSuperview];
    _normalRightView = normalRightView;
    [self addSubview:_normalRightView];
    [self setNeedsLayout];
}
@end
