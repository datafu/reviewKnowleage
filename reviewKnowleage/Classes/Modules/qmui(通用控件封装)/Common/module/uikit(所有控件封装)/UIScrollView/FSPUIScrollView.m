//
//  FSPUIScrollView.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/26.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPUIScrollView.h"

@implementation FSPUIScrollView

//-(BOOL)touchesShouldCancelInContentView:(UIView *)view{
//    if ([view isKindOfClass:[UIImageView class]]) {
//        return YES;
//    }
//    return [super touchesShouldCancelInContentView:view];
//}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}


//NO则立即返回给ScrollView，否则会将touch事件发送给SubView。默认为YES
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
//    if ([view isKindOfClass:[UIImageView class]]) {
//         QMUILog(@"FSPUIScrollView", @"用户点击了scroll上的视图,是否开始滚动scroll");
//        return YES;
//    }
    //不传递touch事件
    
    return YES;

}


@end
