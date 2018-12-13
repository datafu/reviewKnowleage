//
//  FSPCountdownButton.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPCountdownButton.h"

#define btnStartText   @"获取验证码"
#define btnEndText     @"重新获取"

/*
 *  使用xib的button继承本类时需要在xib面板将button type设置为 UIButtonTypeCustom，
 *  否则倒计时时文字会一闪一闪。
 */

@interface FSPCountdownButton ()

@property (nonatomic, assign)NSInteger seconds;
@property (nonatomic, strong, nullable) NSTimer *timer;

@end

@implementation FSPCountdownButton

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:btnStartText forState:UIControlStateNormal];
    }
    return  self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setTitle:btnStartText forState:UIControlStateNormal];
    }
    return self;
}

- (void)startTimer:(NSUInteger) seconds {
    [self setEnabled:NO];
    self.seconds = seconds;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self setEnabled:YES];
    if (self.timer) {
        if ([self.timer respondsToSelector:@selector(isValid)]) {
            if ([self.timer isValid]) {
                [self.timer invalidate];
                self.timer = nil;
            }
        }
    }
    self.backgroundColor = [UIColor colorWithRed:0.698 green:0.553 blue:0.298 alpha:1.000];
    [self setTitle:btnEndText forState:UIControlStateNormal];
    //    [self setTitle:btnEndText forState:UIControlStateDisabled];
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountDown:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)timerCountDown:(NSTimer *)theTimer {
    self.seconds --;
    if (self.seconds < 0) {
        [self stopTimer];
    } else {
        NSString *title = [NSString stringWithFormat:@"剩余%ld秒", (long)self.seconds];
        self.backgroundColor = [UIColor colorWithWhite:0.455 alpha:1.000];
        [self setTitle:title forState:UIControlStateNormal];
        //        [self setTitle:title forState:UIControlStateDisabled];
    }
}

@end
