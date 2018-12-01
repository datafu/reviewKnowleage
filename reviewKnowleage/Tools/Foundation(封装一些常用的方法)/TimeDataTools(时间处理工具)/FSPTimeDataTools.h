//
//  FSPTimeDataTools.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/30.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPTimeDataTools : NSObject


/**
 *  获取当前时间并进行格式化
 *
 *  @param formatString 格式化的格式 例如：@"yyyy-MM-dd HH:mm"
 *
 *  @return 返回格式化后的当前时间字符串
 */
+(NSString *)getCurrentDateWithFormatString:(NSString *)formatString;


/**
 *  获取当前时间并计算延迟后的时间进行格式化
 *
 *  @param formatString 格式化的格式 例如：@"yyyy-MM-dd HH:mm"
 *
 *  @param secondsTimeString 要延迟多长时间
 *
 *  @return 返回格式化后的当前时间字符串
 */
+(NSString *)getCurrentDateWithFormatString:(NSString *)formatString andDelayAfterTime:(NSString *)secondsTimeString;



/**
 传入年和月获取该月有多少天

 @param month 月份
 @param year 年份
 @return 天数
 */
+ (NSInteger)daysCountOfMonth:(NSInteger)month inYear:(NSInteger)year;

@end

NS_ASSUME_NONNULL_END
