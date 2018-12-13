//
//  FSPEditTextField.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//  向输入用户密码编辑器那样  左右可能都有图片或许按钮


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPEditTextField : UIView


/* 左图片 */
@property(nonatomic, strong) IBInspectable UIImage *leftImage;

/**
 *  修改 placeholder ，默认是 placeholder。
 */
@property(nonatomic, strong) IBInspectable NSString *placeholder;



/** 右边的按钮  当存在leftview的时候 需要自定义 避免覆盖
    关于右边按钮 我会提供宏定义 直接创建响应的按钮 即可

 
 */
@property(nonatomic, strong) UIView *normalRightView;


@end

NS_ASSUME_NONNULL_END
