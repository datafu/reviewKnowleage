//
//  FSPNetworkTools.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/17.
//  Copyright © 2018年 fushp. All rights reserved.
//  网络请求工具
/*
 参考: GitHub: https://github.com/jkpang
 使用 http://www.doclever.cn/controller/console/console.html
 作为api管理平台  http://www.doclever.cn:8090/
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /*模型*/
    EnumModel,
    /*模型数组*/
    EnumModelArr
} EnumModelType;

@interface FSPNetworkTools : NSObject


/**
 post 请求

 @param url 服务器的访问url
 @param BodyPragram 请求参数
 @param modelName 解析字段
 @param modelType 默认 1.模型  2.模型数组
 @param successBlock 成功回调
 @param fail 失败回调
 
 */
+ (void)post:(NSString *)url
  andPragram:(NSDictionary *)BodyPragram
   modelName:(NSString*)modelName
   modelType:(EnumModelType)modelType
   successBlock:(void(^)(id model))successBlock
   failBlock:(void (^)(NSURLSessionDataTask *task, id error))fail;


@end

NS_ASSUME_NONNULL_END
