//
//  UIButton+FF.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/22.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "UIButton+FF.h"

@implementation UIButton (FF)

- (void)fillbBorderColor:(UIColor*)TintColor borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth  cornerRadius:(CGFloat)cornerRadius {
    [self setTintColor:TintColor ];
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
@end
