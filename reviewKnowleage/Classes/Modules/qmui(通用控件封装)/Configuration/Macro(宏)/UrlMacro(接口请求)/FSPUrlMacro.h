//
//  FSPUrlMacro.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/17.
//  Copyright © 2018年 fushp. All rights reserved.
//  接口请求相关的宏

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPUrlMacro : NSObject


// 请求关键字
extern NSString * const kHead;
extern NSString * const kHeader;
extern NSString * const kResDesc;
extern NSString * const kBody;
extern NSString * const kReqTime;
extern NSString * const kSource;
extern NSString * const kToken;
extern NSString * const kTid;
extern NSString * const kResCode;

/* 登录 */
extern NSString * const kappLoginAuthenUrl;


@end

NS_ASSUME_NONNULL_END
