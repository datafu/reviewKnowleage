//
//  FSPTouchSubScrollViewController.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/26.
//  Copyright © 2018年 fushp. All rights reserved.
/*  添加一个scrollview 需要有下拉功能 scorllview 添加了subView (该视图是一个指南针 需要拖动指针效果)
    涉及方法： canCancelContentTouches
    默认值为YES,如果为YES，当用户触摸手势已经被确定交给subview响应的时候 ，会立即调用- (BOOL)touchesShouldCancelInContentView:(UIView *)view ，交给此方法处理接下来的动作，如果此方法返回NO，则继续传递给subview，scrollView不会滚动，返回YES，则scrollView会滚动 ，subview 会取消处理这个事件 如果返回NO ，则scrollView不会滚动， subview响应这个触摸事件
 
    delaysContentTouches:
    的值就是YES，如果为YES，就会延迟处理这个触摸手势的意图，直到确定了在极短时间内是否发生了滚动，如果没有滚动 ，就把触摸事件传递给触摸的subview处理 (可以响应事件的控件) ，如果滚动了，则scrollView就会滚动 自身响应触摸事件
 
 */
#import <UIKit/UIKit.h>
#import "BaseCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSPTouchSubScrollViewController : BaseCommonViewController

@end

NS_ASSUME_NONNULL_END
