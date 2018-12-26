//
//  FSPUserInfo.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/17.
//  Copyright © 2018年 fushp. All rights reserved.
//  用户信息


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPUserInfo : NSObject

@property (nonatomic,copy) NSString * account;//用户登录帐号
@property (nonatomic,copy) NSString * token;//鉴权码
@property (nonatomic,copy) NSString * tid;//用户唯一识别码
@end

NS_ASSUME_NONNULL_END
