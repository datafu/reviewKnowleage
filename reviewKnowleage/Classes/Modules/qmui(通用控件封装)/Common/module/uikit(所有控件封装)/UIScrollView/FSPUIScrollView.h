//
//  FSPUIScrollView.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/26.
//  Copyright © 2018年 fushp. All rights reserved.
//
/*
 delaysContentTouches 是否将事件传递给子控件
 canCencelContentTouches(可以取消内容触摸):
  如果为YES，就会等待用户下一步动作，如果用户移动手指到一定距离，就会把这个操作作为滚动来处理并开始滚动，同时发送一个touchesCancelled:withEvent:消息给内容控件，由控件自行处理。如果为NO，就不会等待用户下一步动作，并始终不会触发scrollView的滚动了
 
 检查canCancelContentTouches开关（默认为YES）。如果为N，则将所有后续事件发送到SubView，否则：
 检查touchesShouldCancelInContentView的返回值，如果为N，则将所有事件发送到SubView，否则返回到ScrollView。默认情况下，如果SubView不是UIControl的一种，则返回YES
 
 作者：ac3
 链接：https://www.jianshu.com/p/edf0e75ca86d
 來源：简书
 简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPUIScrollView : UIScrollView

@end

NS_ASSUME_NONNULL_END
