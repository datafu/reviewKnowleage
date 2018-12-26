//
//  SEMIPlayMusicViewController.h
//  SEMI-IV
//
//  Created by 杨俊杰 on 2018/8/15.
//  Copyright © 2018年 soueast-motor. All rights reserved.
//


#import "QMUICommonViewController.h"
#import "BaseCommonViewController.h"


@class SEMIPlayMusicViewController;

/** 播放模式 */
typedef NS_ENUM(NSUInteger,PlayerMode) {
    /** 列表循环 */
    PlayerModeListCycle = 0 ,
    /** 随机播放 */
    PlayerModeRandom ,
    /** 单曲循环 */
    PlayerModeOneCycle
};

@protocol SEMIPlayMusicViewControllerDelegate <NSObject>


@end

@interface SEMIPlayMusicViewController :BaseCommonViewController

/** 是否正在播放中 */
@property (nonatomic,assign) BOOL isPlaying;



@end
