//
//  FSPColorLabel.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/29.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPColorLabel.h"
#import "UIColor+FF.h"
@implementation FSPColorLabel

- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    // 重绘
    [self setNeedsDisplay];
}



- (void)setWillDisprogress:(CGFloat)willDisprogress{
    
    _willDisprogress = willDisprogress;
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    // 设置颜色
    [self.currentColor set];
    rect.size.width *= self.progress;
    // 图形混合模式
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

- (UIColor *)currentColor {
    
    if (_currentColor == nil) {
        _currentColor = [UIColor qmui_colorWithHexString:@"#e06448"];
    }
    return _currentColor;
}

- (UIColor*)currentWillDisColor {
    if (_currentWillDisColor == nil) {
        _currentWillDisColor =  [UIColor colorWithHexString:@"#ffffff" alpha:0.2];
    }
    return _currentWillDisColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
 
}

@end
