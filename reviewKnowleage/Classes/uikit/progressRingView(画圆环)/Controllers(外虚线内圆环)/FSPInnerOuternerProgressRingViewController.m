//
//  FSPInnerOuternerProgressRingViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/1.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPInnerOuternerProgressRingViewController.h"
#import "FSPProgressRingView.h"
#import "FSPElectricView.h"
#import <Masonry.h>
@interface FSPInnerOuternerProgressRingViewController ()
@property(nonatomic, strong) FSPProgressRingView *progressRingView;
@property(nonatomic, strong) FSPElectricView *electricView;
@end

@implementation FSPInnerOuternerProgressRingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressRingView;
    self.electricView;
//    self.progressRingView.mileage = 200;
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.progressRingView.mileage = 100;
        weakSelf.electricView.electric = 0.4;
    });
}


- (FSPProgressRingView*)progressRingView {
    if (!_progressRingView) {
        _progressRingView = [[FSPProgressRingView alloc] init];
        [self.view addSubview:_progressRingView];
        [_progressRingView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.centerY.mas_equalTo(self.view .mas_centerY);
            make.size.mas_equalTo(CGSizeMake(150, 150));
        }];
    }
    return _progressRingView;
}

-(FSPElectricView*)electricView
{
    if (!_electricView) {
        _electricView =[[FSPElectricView alloc] init];
        _electricView.backgroundColor  = [UIColor clearColor];
        //masony
        [self.view addSubview:_electricView];
        [_electricView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.progressRingView);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    return _electricView;
}

@end
