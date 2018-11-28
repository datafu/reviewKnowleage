//
//  AppDelegate+FSPJPush.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/21.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#import <objc/runtime.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (FSPJPush)<JPUSHRegisterDelegate>
/*
 is_loginSuccess: YES 成功登录  NO 失败登录
 
 */
@property(nonatomic, assign) BOOL is_loginSuccess;

/*
 * 推送获取的消息
 {
 "id":"****",//取mongodb中的唯一标识
 "push_time":"yyyy-MM-dd HH:mm:ss",
 "message_type":"3", // 大类
 "type":"2" // 小类
 }
 */
@property (nonatomic,strong)   NSDictionary *pushMessage;
/// 未读状态
@property (nonatomic,strong)   NSMutableDictionary *noreadStatus;


/** 极光推送初始化方法*/
- (void)setJPush:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
/**  进入后台的方法*/
- (void)JPushDidEnterBackground:(UIApplication *)application;
/** 将要进入前台的时候的方法*/
- (void)JPushWillEnterForeground:(UIApplication *)application;
/** 设置别名*/
- (void)jpushSetAlias:(NSString*)alias;
/** 删除别名*/
- (void)jpushDelAlias;
/** 设置标签*/
- (void)setTags:(NSSet*)tags;
/** 增加标签*/
- (void)addTags:(NSSet*)tag;
/** 删除标签*/
- (void)delTags;
/** 显示消息中心详情*/
- (void)pushSEMIMessageDetailViewController;
@end

NS_ASSUME_NONNULL_END
