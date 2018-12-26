//
//  FSPUserMangager.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/17.
//  Copyright © 2018年 fushp. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "FSPUserInfo.h"
NS_ASSUME_NONNULL_BEGIN


#define userManager [FSPUserMangager sharedFSPUserMangager]


@interface FSPUserMangager : NSObject

//单例
SINGLETON_FOR_HEADER(FSPUserMangager);

//+ (FSPUserMangager *)sharedFSPUserMangager;

//当前用户
@property (nonatomic, strong) FSPUserInfo *curUserInfo;

@end

NS_ASSUME_NONNULL_END
