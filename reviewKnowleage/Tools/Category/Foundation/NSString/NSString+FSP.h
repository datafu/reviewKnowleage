//
//  NSString+FSP.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/16.
//  Copyright © 2018年 fushp. All rights reserved.
//  字符串添加一些新的方法

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FSP)

/********************* 时间类转化方法 *********************************/


/**
 时间戳转换为时间字符串的方法

 @param formatString formatString 格式化的格式 例如：@"yyyy-MM-dd HH:mm"
 @return  时间字符串
 */
- (NSString *)dateStringWithTimeStamp:(NSString *)formatString;



/**
 时间字符串转换为时间字符串的方法

 @param tmpFormateString  转换前字符串格式  例如：@"yyyy.MM.dd HH:mm"
 @param formateString 格式化的格式 例如：@"yyyy-MM-dd HH:mm"
 @return 时间字符串
 */
- (NSString *)dateStringWithString:(NSString *)tmpFormateString andFormatString:(NSString *)formateString;





@end

NS_ASSUME_NONNULL_END
