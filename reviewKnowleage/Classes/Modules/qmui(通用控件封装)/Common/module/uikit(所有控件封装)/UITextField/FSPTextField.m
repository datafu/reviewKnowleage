//
//  FSPTextField.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/26.
//  Copyright © 2018 fushp. All rights reserved.
//

#import "FSPTextField.h"

@implementation FSPTextField

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
    self.font = [QDThemeManager sharedInstance].currentTheme.themeTintFont;
//    UIButton *clearButton = [self valueForKey:@"_clearButton"];
//    [clearButton setImage:[UIImage imageNamed:@"login_del_ico"] forState:UIControlStateNormal];
}

//设置左图片 xib可见
- (void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    UIImageView *img = [[UIImageView alloc] initWithImage:leftImage];
    self.leftView  = img;
    self.leftViewMode = UITextFieldViewModeAlways;
}

/// 直接添加一个按钮
- (void)setNormalRightView:(UIView *)normalRightView {
    [self addSubview:normalRightView];
    _normalRightView = normalRightView;
    self.clearButtonPositionAdjustment = UIOffsetMake(- normalRightView.frame.size.width, 0);
    [self setNeedsLayout];
}

//- (CGRect)leftViewRectForBounds:(CGRect)bounds{
//    CGRect iconRect = [super leftViewRectForBounds:bounds];
//    iconRect.origin.x += 10;
//    return iconRect;
//}


- (void)layoutSubviews {
    [super layoutSubviews];
    _normalRightView.frame = CGRectSetXY(_normalRightView.frame, CGRectGetWidth(self.frame) - CGRectGetWidth(_normalRightView.frame) , (CGRectGetHeight(self.frame) - CGRectGetHeight(_normalRightView.frame))/ 2.0);
    
}









@end
