//
//  FSPColorLabel.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/29.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPColorLabel : UILabel

/** 歌词播放进度 */
@property (nonatomic,assign) CGFloat progress;

/** 歌词颜色 */
@property (nonatomic,strong) UIColor *currentColor;


/** 歌词出现或者消失 颜色 */
@property (nonatomic,strong) UIColor *currentWillDisColor;

/** 歌词出现或者消失 进度 */
@property (nonatomic,assign) CGFloat willDisprogress;

/** 歌词渐变 */
@property(nonatomic, strong) CAGradientLayer *fadeLayer;
/** 歌词是否应该渐变 */
@property (nonatomic,assign) BOOL shouldShowFadeLayer;


@end

NS_ASSUME_NONNULL_END
