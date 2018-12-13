//
//  FSPBaseButton.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//
/*
    做为所有按钮的基类
    按钮大体分类这几种:
    1.弹出样式的  取消 确定按钮  普通按钮
    2.实心填充颜色 一般是加载整个视图当中 比如 完成
    3.“幽灵”按钮，也即背景透明、带圆角边框的按钮 比如 取消 跳过等字样
    4. 下划线按钮
 
 */


#import "QMUIButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSPNormalBUtton : QMUIButton

@end

NS_ASSUME_NONNULL_END
