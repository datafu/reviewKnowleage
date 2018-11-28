//
//  AppDelegate+FSPJPush.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/21.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "AppDelegate+FSPJPush.h"
#define isIOS10 ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
#define isIOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
//需要替换的部分
#define JPushKey      @"2e6b5d22c173cfd679bb7b41"
@implementation AppDelegate (FSPJPush)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)setJPush:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    if (isIOS10) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }else if (isIOS8) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    BOOL isProduction;
    NSString *channel;
#if DEBUG
    isProduction = NO;
    channel = @"App Hoc";
#else
    isProduction = YES;
    channel = @"App Store";
#endif
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    //iOS 10以下 ios 7以上程序杀死的时候点击收到的通知进行的跳转操作
    if (launchOptions && !isIOS10){
        NSDictionary *pushDict = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        [self handleNotification:pushDict];
    }
    self.noreadStatus = [NSMutableDictionary dictionary];
    
}

#pragma clang diagnostic pop

#pragma mark 极光推送的代理的方法
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
    NSString * devicetoken =  [ NSString stringWithFormat:@"didRegisterForRemoteNotificationsWithDeviceToken：%@",deviceToken];
//    [[SEMILogManager shareInstance] writeMessageToFileWithStr:devicetoken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    [[SEMILogManager shareInstance] writeMessageToFileWithStr:@"didFailToRegisterForRemoteNotificationsWithError"];
}



//ios 7以上 iOS10 以下处理前台和后台通知的做法
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    //前台与后台的处理
//    BKLog(@"%@",userInfo);
    if (application.applicationState == UIApplicationStateActive) {
        //        [TXAlertView showAlertWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] cancelButtonTitle:@"好的" style:TXAlertViewStyleAlert buttonIndexBlock:^(NSInteger buttonIndex) {
        //            if (buttonIndex == 1) {
        //                [weakSelf handleNotification:userInfo];
        //            }
        //        } otherButtonTitles:@"去看看", nil];
    }else{
        //当程序在后台运行的时候处理的通知
        [self handleNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//ios 10程序在前台收到通知处理
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //ios 10前台获取推送消息内容
        //前台收到消息直接对消息处理 不点击
        //判断当前页面是否处于消息中心页面 是 发送信号 让他请求下数据,否 忽略即可
        
    }else {
        // 判断为本地通知
    }
    // 如果当前活跃界面不是在消息中心 则记录小红点即可
    //除了 1～4的消息 其他都不理会
    NSInteger messageType = [userInfo[@"message_type"] integerValue];
    if ( messageType <1 ||messageType >4) { //消息中心才处理 其他不理会
        return ;
    }
    [self.noreadStatus  setObject:@YES forKey:userInfo[@"message_type"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getvpnsmessage" object:nil userInfo:userInfo];
//    BKLog(@"willPresentNotification::::%@",userInfo);
    //    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

//ios 10在这里处理通知点击跳转
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //ios  无论程序在前台或者程序在后台点击的跳转处理
        [JPUSHService handleRemoteNotification:userInfo];
        [self handleNotification:userInfo];
    }else {
        // 判断为本地通知
        
    }
//    BKLog(@"%@",userInfo);
    completionHandler();  // 系统要求执行这个方法
}

#pragma clang diagnostic pop
//点击推送弹窗进行的处理
- (void)handleNotification:(NSDictionary *)userInfo{
    //    [[SEMILogManager shareInstance] writeMessageToFileWithStr:@"收到推送消息"];
    //    [[SEMILogManager shareInstance] writeMessageToFileWithJsonStr:userInfo];
    //    LLog_Alert_Event(@"收到推送消息",[NSString stringWithFormat:@"%@",userInfo]);
    
    self.pushMessage = userInfo;
    QMUINavigationController* naVc = (QMUINavigationController*) self.window.rootViewController;
    //除了 1～4的消息 其他都不理会
    NSInteger messageType = [userInfo[@"message_type"] integerValue];
    if ( messageType <1 ||messageType >4) { //消息中心才处理 其他不理会
        return ;
    }
    ///判断是否登录成功
//    [self.noreadStatus  setObject:@YES forKey:userInfo[@"message_type"]];
//    if (self.is_loginSuccess) {//直接在当前首页push页面
//        if ([naVc.topViewController isKindOfClass:[SEMIMessageViewController class]]) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"getvpnsmessage" object:nil userInfo:userInfo];
//            return ;
//        }else if([naVc.topViewController isKindOfClass:[SEMIHomePageViewController class]]){ //在首页中
//            [self pushSEMIMessageDetailViewController];
//        }else{//其他页面 先pop 到首页
//            //获取首页的位置
//            UIViewController * homevc = naVc.viewControllers[1];
//            [naVc popToViewController:homevc animated:NO];
//        }
//
//    }else{//等进入首页的时候再进行push操作
//
//    }
//
    
    
}

- (void)JPushDidEnterBackground:(UIApplication *)application{
    //重新设置角标
    [JPUSHService resetBadge];
    [JPUSHService setBadge:0];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)JPushWillEnterForeground:(UIApplication *)application{
    [application setApplicationIconBadgeNumber:0];
}

///设置别名
- (void)jpushSetAlias:(NSString*)alias {
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%ld",(long)iResCode);
    } seq:1];
}
/// 删除别名
- (void)jpushDelAlias {
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%ld",(long)iResCode);
    } seq:1];
}
/// 设置标签
- (void)setTags:(NSSet*)tags {
    [JPUSHService setTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSLog(@"%ld",(long)iResCode);
    } seq:1];
}
/// 增加标签
- (void)addTags:(NSSet*)tag {
    [JPUSHService addTags:tag completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSLog(@"%ld",(long)iResCode);
    } seq:1];
}
/// 删除标签
- (void)delTags {
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSLog(@"%ld",(long)iResCode);
    } seq:1];
}

//Json字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


/// 推送获取的消息
static NSString * kAssociatedObjectKey_message;
- (void)setPushMessage:(NSDictionary *)pushMessage {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_message, pushMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)pushMessage {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_message);
}

//记录收到推送消息未读状态
static NSString * kAssociatedObjectKey_NoReadStatus;
- (void)setNoreadStatus:(NSMutableDictionary *)noreadStatus{
    objc_setAssociatedObject(self, &kAssociatedObjectKey_NoReadStatus, noreadStatus, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSMutableDictionary *)noreadStatus {
    
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_NoReadStatus);
}



/// 是否登录成功
static NSString * kAssociatedObjectKey_is_loginSuccess;
- (void)setIs_loginSuccess:(BOOL)is_loginSuccess {
    NSNumber *number = [NSNumber numberWithBool: is_loginSuccess];
    objc_setAssociatedObject(self, &kAssociatedObjectKey_is_loginSuccess, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
}
- (BOOL)is_loginSuccess {
    NSNumber *number = objc_getAssociatedObject(self, &kAssociatedObjectKey_is_loginSuccess);
    return [number boolValue];
}


/// 显示消息中心界面 保证当前页面在首页
- (void) pushSEMIMessageDetailViewController {
    
//    QMUINavigationController* naVc = (QMUINavigationController*) self.window.rootViewController;
    //    LLog_Alert_Event(@"点击推送消息",[NSString stringWithFormat:@"%@",self.pushMessage]);
    
    //如果当前显示页已经是消息中心 直接发送通知即可
    //    if ([naVc.topViewController isKindOfClass:[SEMIMessageViewController class]]) {
    //         [[NSNotificationCenter defaultCenter] postNotificationName:@"getvpnsmessage" object:nil userInfo:userInfo];
    //        return ;
    //    }else if([naVc.topViewController isKindOfClass:[SEMIHomePageViewController class]]){ //在首页中
    //
    //    }else{//其他页面 先pop 到首页
    //        //获取首页的位置
    //        UIViewController * homevc = naVc.viewControllers[1];
    //        [naVc popToViewController:homevc animated:NO];
    //    }
    //如果不是消息中心 需要先pop当首页 然后再跳转
    
    
    //创建导航控制器 push新的页面过去
    //    SEMIMessageDetailViewController *messageVc = [[SEMIMessageDetailViewController alloc] init];
    //    messageVc.messageId = self.pushMessage[@"id"];
//    SEMIMessageViewController *messageVc = [[SEMIMessageViewController alloc] init];
//    messageVc.messageId = self.pushMessage[@"id"];
//    messageVc.message_type = [self.pushMessage[@"message_type"] integerValue] ;
    //使用模态方式 push
    //    CATransition *transition = [CATransition animation];
    //    transition.duration = 0.5;
    //    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    //    transition.type = kCATransitionPush;
    //    transition.subtype = kCATransitionFromTop;
    //    [naVc.view.layer addAnimation:transition forKey:nil];
    //隐藏跳转的页面的导航条：实质是PUSH，所以用POP 推出
//    [naVc pushViewController:messageVc animated:NO];
//    self.pushMessage = nil;
    
//}



@end
