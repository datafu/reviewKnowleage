//
//  FSPLrcModel.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/29.
//  Copyright © 2018年 fushp. All rights reserved.
//  歌词模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 每句歌词 */
@interface FSPLrcModel : NSObject
@property(nonatomic,assign) NSTimeInterval time;
@property(nonatomic,copy)NSString * lrc;
@end


@interface wslAnalyzer : NSObject

@property(nonatomic,strong)NSMutableArray * lrcArray;

//返回包含每一句歌词信息的数组
-(NSMutableArray *)analyzerLrcByPath:(NSString *)path;

-(NSMutableArray *)analyzerLrcBylrcString:(NSString *)string;
+ (NSArray *)parserLyricWithFileName:(NSString *) content;
@end

@interface NSDateFormatter (shared)

/** 对于重大开销对象最好使用单例管理 */
+ (instancetype)sharedDateFormatter;
@end


NS_ASSUME_NONNULL_END
