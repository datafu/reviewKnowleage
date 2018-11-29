//
//  NSString+FSP.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/16.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "NSString+FSP.h"

@implementation NSString (FSP)

//时间戳转换为时间方法
- (NSString *)dateStringWithTimeStamp:(NSString *)formatString{
    NSString *dateString;
    NSDate *tmpDate = [NSDate dateWithTimeIntervalSince1970:[self floatValue]];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:formatString];
    dateString = [format stringFromDate:tmpDate];
    return dateString;
    
}

//时间字符串转换为时间字符串的方法
- (NSString *)dateStringWithString:(NSString *)tmpFormateString andFormatString:(NSString *)formateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:tmpFormateString];
    NSDate *date = [formatter dateFromString:self];
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formateString];
    return [formatter stringFromDate:date];

}



@end
