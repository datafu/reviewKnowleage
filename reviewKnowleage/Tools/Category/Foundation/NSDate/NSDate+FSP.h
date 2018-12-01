//
//  NSDate+FSP.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/16.
//  Copyright © 2018年 fushp. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSDate (FSP)

/**
 格式化NSDate

 @param formatString 格式化的格式 例如：@"yyyy-MM-dd HH:mm"
 @return 格式化后的时间字符串
 */
- (NSString *)dateStringWithDate:(NSString *)formatString;


/**
 时间转换为时间戳方法

 @return 时间戳字符串
 */
- (NSString *)timeStampWithDate;




@end

NS_ASSUME_NONNULL_END
