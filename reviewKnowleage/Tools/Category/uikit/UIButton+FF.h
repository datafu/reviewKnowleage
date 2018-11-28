//
//  UIButton+FF.h
//  reviewKnowleage
//
//  Created by fushp on 2018/10/22.
//  Copyright © 2018年 fushp. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIButton (FF)
/** 设置背景色 和边框色*/
- (void)fillbBorderColor:(UIColor*)TintColor borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth  cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
