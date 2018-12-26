//
//  FSPLyricView.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/29.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FSPLyricView;

@protocol FSPLyricViewDelegate  <NSObject>

@optional
- (void)lyricView:(FSPLyricView *)lyricView withProgress:(CGFloat)progress;

/** 设置拉动时间 */
- (void)lyricView:(NSTimeInterval)SetTime;
@end



@interface FSPLyricView : UIView
@property (nonatomic,weak) id <FSPLyricViewDelegate> delegate;

/** 歌词模型数组 */
@property (nonatomic,strong) NSArray *lyrics;

/** 每行歌词行高 */
@property (nonatomic,assign) NSInteger rowHeight;

/** 当前正在播放的歌词索引 */
@property (nonatomic,assign) NSInteger currentLyricIndex;

/** 歌曲播放进度 */
@property (nonatomic,assign) CGFloat lyricProgress;

/** 竖直滚动的view，即歌词View */
@property (nonatomic,weak) UIScrollView *vScrollerView;

/** 歌词是否应该渐变 */
@property(nonatomic, strong) CAGradientLayer *fadeLayer;


@end

NS_ASSUME_NONNULL_END
