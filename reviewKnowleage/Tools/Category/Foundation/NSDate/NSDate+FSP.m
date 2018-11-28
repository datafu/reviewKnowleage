//
//  NSDate+FSP.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/16.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "NSDate+FSP.h"

@implementation NSDate (FSP)


//格式化NSDate
-(NSString *)dateStringWithDate:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSString *dateString = [dateFormatter stringFromDate:self];
    return dateString;
}

//NSDate转时间戳
- (NSString *)timeStampWithDate {
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[self timeIntervalSince1970]];
    return timeStamp;
}
@end
