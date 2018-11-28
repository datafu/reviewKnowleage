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
    
}


////控制清除按钮的位置
//-(CGRect)clearButtonRectForBounds:(CGRect)bounds
//{
//    CGFloat width = CGRectGetWidth(self.rightView.frame);
//    QMUILog(@"clearButtonRectForBounds",@"%f",width);
//    return CGRectMake(bounds.origin.x - width, bounds.origin.y, bounds.size.height, bounds.size.height);
//
////    return CGRectMake(bounds.origin.x + bounds.size.width - 55, bounds.origin.y, bounds.size.height, bounds.size.height);
//}
//
//
//// 重写设置右边距
//- (CGRect) rightViewRectForBounds:(CGRect)bounds {
//
//    CGRect textRect = [super rightViewRectForBounds:bounds];
//    textRect.origin.x -= 10;
//    return textRect;
//}




- (void)layoutSubviews{
    [super layoutSubviews];
    
}




@end
