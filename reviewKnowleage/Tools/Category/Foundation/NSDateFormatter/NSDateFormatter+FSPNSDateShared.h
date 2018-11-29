//
//  NSDateFormatter+FSPNSDateShared.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/29.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (FSPNSDateShared)
/** 对于重大开销对象最好使用单例管理 */
+ (instancetype)sharedDateFormatter;

@end

NS_ASSUME_NONNULL_END
