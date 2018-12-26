//
//  FSPSliderView.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/29.
//  Copyright © 2018年 fushp. All rights reserved.
//   指示条 当滚动歌词的时候 会显示


#import <UIKit/UIKit.h>
typedef void (^FSPSliderViewBlock)(NSTimeInterval time);

NS_ASSUME_NONNULL_BEGIN

@interface FSPSliderView : UIView
@property (nonatomic,assign) NSTimeInterval time;
@property(nonatomic,copy) FSPSliderViewBlock sliderviewblock;

@end

NS_ASSUME_NONNULL_END
