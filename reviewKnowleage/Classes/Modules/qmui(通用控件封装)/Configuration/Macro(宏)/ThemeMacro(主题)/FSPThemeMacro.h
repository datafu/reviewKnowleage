//
//  FSPThemeMacro.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//
/*
 
 1. 颜色字体 大小
    当 QMUIConfigurationTemplate 没有相关选项的时候 就从这个去读取
    1.1 QMUIConfigurationTemplate
        UIColorPlaceholder  默认用于 QMUITextField、QMUITextView
       
    1.2  textfield 字体大小
 
 
 2. URL: 服务器的url
 3. 提示语 (包括 请求结果提示语  失败提示语 )
 4. 默认文案 (主要是 textfield)
 
 
 
 */


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPThemeMacro : NSObject


/* 主要按钮样式 */

#define MacroColor_80bfff_alpha(a) [UIColor colorWithRed:128.0 / 255.0 green:191.0 / 255.0 blue:45.0/255.0 alpha:(a)]

/* QMUITextField、QMUITextView 字体大小 */
extern CGFloat const kTextSize ;

/* Button cornerRadius size */
extern CGFloat const kButtonTextSize ;

/* Button cornerRadius*/


/** ****************** 刷新提示语 *********************** */
/** 下拉刷新提示语 - 普通闲置状态 */
extern NSString * const kRefreshStateIdle;
/** 下拉刷新提示语 - 松开就可以进行刷新的状态 */
extern NSString * const kRefreshStatePulling;
/** 下拉刷新提示语 - 正在刷新中的状态 */
extern NSString * const kRefreshStateRefreshing;
/** 上拉加载提示语 - 普通闲置状态 */
extern NSString * const kLoadMoreStateIdle;
/** 上拉加载提示语 - 正在刷新中的状态 */
extern NSString * const kLoadMoreStateRefreshing;
/** 上拉加载提示语 - 所有数据加载完毕，没有更多的数据了 */
extern NSString * const kLoadMoreStateNoMoreData;


@end

NS_ASSUME_NONNULL_END
