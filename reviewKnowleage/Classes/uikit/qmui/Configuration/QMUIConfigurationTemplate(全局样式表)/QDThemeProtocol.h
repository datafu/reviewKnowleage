//
//  QDThemeProtocol.h
//  reviewKnowleage
//
//  Created by fushp on 2018/10/16.
//  Copyright © 2018年 fushp. All rights reserved.
//  主题类协议 也是皮肤管理协议

#import <Foundation/Foundation.h>

@protocol QDThemeProtocol <QMUIConfigurationTemplateProtocol>


@required


- (UIColor *)themeTintColor;
- (UIColor *)themeListTextColor;
- (UIColor *)themeCodeColor;
- (UIColor *)themeGridItemTintColor;
- (NSString *)themeName;

@end


/// 所有能响应主题变化的对象均应实现这个协议，目前主要用于 QDCommonViewController 及 QDCommonTableViewController
@protocol QDChangingThemeDelegate <NSObject>

@required

- (void)themeBeforeChanged:(NSObject<QDThemeProtocol> *)themeBeforeChanged afterChanged:(NSObject<QDThemeProtocol> *)themeAfterChanged;

@end

