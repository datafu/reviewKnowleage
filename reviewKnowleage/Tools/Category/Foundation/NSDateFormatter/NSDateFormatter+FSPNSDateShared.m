//
//  NSDateFormatter+FSPNSDateShared.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/29.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "NSDateFormatter+FSPNSDateShared.h"

@implementation NSDateFormatter (FSPNSDateShared)
+(instancetype)sharedDateFormatter {
    static NSDateFormatter *_dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[self alloc]  init];
        
    });
    return _dateFormatter;
}
@end
