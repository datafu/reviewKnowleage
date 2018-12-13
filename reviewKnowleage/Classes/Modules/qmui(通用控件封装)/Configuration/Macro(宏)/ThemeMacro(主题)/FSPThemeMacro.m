//
//  FSPThemeMacro.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPThemeMacro.h"

@implementation FSPThemeMacro



/* QMUITextField、QMUITextView 字体大小 */

CGFloat const kTextSize = 14;

/* Button cornerRadius size */
CGFloat const kButtonTextSize = 16 ;



/** 下拉刷新提示语 - 普通闲置状态 */
NSString * const kRefreshStateIdle = @"下拉可以刷新...";
/** 下拉刷新提示语 - 松开就可以进行刷新的状态 */
NSString * const kRefreshStatePulling = @"松开即可刷新...";
/** 下拉刷新提示语 - 正在刷新中的状态 */
NSString * const kRefreshStateRefreshing = @"正在加载中...";
/** 上拉加载提示语 - 普通闲置状态 */
NSString * const kLoadMoreStateIdle = @"加载更多";
/** 上拉加载提示语 - 正在刷新中的状态 */
NSString * const kLoadMoreStateRefreshing = @"正在加载中...";
/** 上拉加载提示语 - 所有数据加载完毕，没有更多的数据了 */
NSString * const kLoadMoreStateNoMoreData = @"我是有底线的";


@end
