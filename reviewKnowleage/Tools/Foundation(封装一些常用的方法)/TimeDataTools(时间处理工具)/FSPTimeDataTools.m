//
//  FSPTimeDataTools.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/30.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPTimeDataTools.h"
#import "NSDate+FSP.h"

@implementation FSPTimeDataTools


//获取当前时间并进行格式化
+(NSString *)getCurrentDateWithFormatString:(NSString *)formatString{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间，日期
    return [currentDate dateStringWithDate:formatString];
}

+(NSString *)getCurrentDateWithFormatString:(NSString *)formatString andDelayAfterTime:(NSString *)secondsTimeString{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:[secondsTimeString doubleValue]];//获取当前时间，日期
    return [currentDate dateStringWithDate:formatString];
}


// 传入年份和月份 返回 当月有多少天
+ (NSInteger)daysCountOfMonth:(NSInteger)month inYear:(NSInteger)year
{
    if((month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12))
    return 31;
    
    if((month == 4)||(month == 6)||(month == 9)||(month == 11))
    return 30;
    
    if(year%4==0 && year%100!=0)//普通年份，非100整数倍
    return 29;
    
    if(year%400 == 0)//世纪年份
    return 29;
    
    return 28;
}

@end
