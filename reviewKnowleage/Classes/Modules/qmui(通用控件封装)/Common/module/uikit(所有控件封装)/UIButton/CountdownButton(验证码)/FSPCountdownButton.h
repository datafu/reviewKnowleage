//
//  FSPCountdownButton.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//  倒计时按钮

#import "FSPGhostButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSPCountdownButton : FSPGhostButton

- (void)startTimer:(NSUInteger) seconds;
- (void)stopTimer;

@end

NS_ASSUME_NONNULL_END
