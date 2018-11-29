//
//  FSPLrcModel.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/29.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPLrcModel.h"
#import "NSDateFormatter+FSPNSDateShared.h"

@implementation FSPLrcModel

@end


@implementation wslAnalyzer

-(NSMutableArray *)lrcArray
{
    if (_lrcArray == nil) {
        _lrcArray = [[NSMutableArray alloc] init];
    }return _lrcArray;
}

-(NSMutableArray *)analyzerLrcByPath:(NSString *)path
{
    
    [self  analyzerLrc:[NSString   stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil]];
    
    return self.lrcArray;
}

-(NSMutableArray *)analyzerLrcBylrcString:(NSString *)string{
    
    [self  analyzerLrc:string];
    
    return self.lrcArray;
}

//根据换行符\n分割字符串，获得包含每一句歌词的数组
-(void)analyzerLrc:(NSString *)lrcConnect
{
    
    NSArray *  lrcConnectArray = [lrcConnect   componentsSeparatedByString:@"\n"];
    
    NSMutableArray    *  lrcConnectArray1 =[[NSMutableArray  alloc] initWithArray: lrcConnectArray ];
    
    for (NSUInteger i = 0;  i < [lrcConnectArray1  count]  ;i++ ) {
        if ([lrcConnectArray1[i]   length] == 0 ) {
            [lrcConnectArray1  removeObjectAtIndex:i];
            i--;
        }
    }
    
    //    NSMutableArray * realLrcArray = [self  deleteNoUseInfo:lrcConnectArray1];
    [self    analyzerEachLrc:lrcConnectArray1];
    
}
//删除没有用的字符
-(NSMutableArray *)deleteNoUseInfo:(NSMutableArray *)lrcmArray
{
    for (NSUInteger i = 0; i < [lrcmArray count] ; i++)
    {
        unichar  ch = [lrcmArray[i] characterAtIndex:1];
        if(!isnumber(ch)){
            [lrcmArray removeObjectAtIndex:i];
            i--;
        }
    }
    return lrcmArray;
}

//解析每一行歌词字符，获得时间点和对应的歌词
-(void)analyzerEachLrc:(NSMutableArray *)lrcConnectArray
{
    for (NSUInteger i = 0;  i < [lrcConnectArray  count] ;  i++) {
        //.跳过指定行
        if ([lrcConnectArray[i]  hasPrefix:@"[ti"] ||[lrcConnectArray[i]  hasPrefix:@"[ar"] || [lrcConnectArray[i]  hasPrefix:@"[al"] || [lrcConnectArray[i]  hasPrefix:@"[by"] || ![lrcConnectArray[i] hasPrefix:@"["]){
            continue;
        }
        NSArray * eachLrcArray = [lrcConnectArray[i]   componentsSeparatedByString:@"]"];
        
        NSString * lrc = [eachLrcArray  lastObject];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df  setDateFormat:@"[mm:ss.SS"];
        
        NSDate * date1 = [df  dateFromString:eachLrcArray[0] ];
        NSDate *date2 = [df dateFromString:@"[00:00.00"];
        NSTimeInterval  interval1 = [date1  timeIntervalSince1970];
        NSTimeInterval  interval2 = [date2  timeIntervalSince1970];
        interval1 -= interval2;
        if (interval1 < 0) {
            interval1 *= -1;
        }
        
        //如果时间点对应的歌词为空就不加入歌词数组
        //        if (lrc.length == 0 || [lrc isEqualToString:@"\r"] || [lrc isEqualToString:@"\n"]) {
        //            continue;
        //        }
        FSPLrcModel   * eachLrc = [[FSPLrcModel alloc] init];
        eachLrc.lrc = lrc;
        eachLrc.time =  interval1;
        [self.lrcArray addObject:eachLrc];
        
    }
    
   
}

+ (NSArray *)parserLyricWithFileName:(NSString *)content {
    
    NSString *lyricStr =content;
    // 将歌词总体字符串按行拆分开，每句都作为一个数组元素存放到数组中
    NSArray *lineStrs = [lyricStr componentsSeparatedByString:@"\n"];
    
    // 设置歌词时间正则表达式格式
    NSString *pattern = @"\\[[0-9]{2}:[0-9]{2}.[0-9]{2}\\]";
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL];
    
    // 创建可变数组存放歌词模型
    NSMutableArray *lyrics = [NSMutableArray array];
    
    // 遍历歌词字符串数组
    for (NSString *lineStr in lineStrs) {
        
        NSArray *results = [reg matchesInString:lineStr options:0 range:NSMakeRange(0, lineStr.length)];
        
        // 歌词内容
        NSTextCheckingResult *lastResult = [results lastObject];
        NSString *content = [lineStr substringFromIndex:lastResult.range.location + lastResult.range.length];
        
        // 每一个结果的range
        for (NSTextCheckingResult *result in results) {
            
            NSString *time = [lineStr substringWithRange:result.range];
            
#warning 对于 NSDateFormatter 类似的重大开小对象，最好使用单例管理
            NSDateFormatter *formatter = [NSDateFormatter sharedDateFormatter];
            formatter.dateFormat = @"[mm:ss.SS]";
            NSDate *timeDate = [formatter dateFromString:time];
            NSDate *initDate = [formatter dateFromString:@"[00:00.00]"];
            
            // 创建模型
            FSPLrcModel *lyric = [[FSPLrcModel alloc] init];
            lyric.lrc = content;
            // 歌词的开始时间
            lyric.time = [timeDate timeIntervalSinceDate:initDate];
            
            // 将歌词对象添加到模型数组汇总
            [lyrics addObject:lyric];
        }
    }
    
    // 按照时间正序排序
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    [lyrics sortUsingDescriptors:@[sortDes]];
    
    return lyrics;
}


@end


