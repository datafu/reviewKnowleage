//
//  FSPLyricView.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/29.
//  Copyright © 2018年 fushp. All rights reserved.
//  歌词视图
// 忽略前缀
#define MAS_SHORTHAND

// 集中装箱  基本数据类型转换成对象
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#import "FSPColorLabel.h"
#import "FSPLrcModel.h"
#import "FSPLyricView.h"
#import "FSPSliderView.h"

@interface FSPLyricView ()<UIScrollViewDelegate>

/* 水平滚动的大view，包含音乐播放界面及歌词界面 */
@property (nonatomic,weak) UIScrollView *hScrollerView;

///** 定位播放的View */
@property (nonatomic,weak) FSPSliderView *sliderView;

@end

@implementation FSPLyricView
@synthesize currentLyricIndex = _currentLyricIndex;

// init 方法会调用 initwithframe
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

// xib 会调用该方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}


- (void)setUp {
    //此处添加渐变色
    self.backgroundColor =[UIColor clearColor];
    self.layer.mask =self.fadeLayer;
    UIScrollView *vScrollerView = [[UIScrollView alloc] init];
    [self addSubview:vScrollerView];
    vScrollerView.delegate = self;
    self.vScrollerView = vScrollerView;
    self.vScrollerView.showsVerticalScrollIndicator= NO;
    [vScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 添加sliderView
    FSPSliderView *sliderView = [[FSPSliderView alloc] init];
    [self addSubview:sliderView];
    sliderView.hidden = YES;
    self.sliderView = sliderView;
    __weak __typeof(self)weakSelf = self;
    sliderView.sliderviewblock = ^(NSTimeInterval time) {
        if ([weakSelf.delegate respondsToSelector:@selector(lyricView:)]) {
            [weakSelf.delegate lyricView:time];
        }
    };
    
    [sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.width.equalTo(self);
        make.height.mas_equalTo(self.rowHeight);
    }];
    
}
- (CAGradientLayer*)fadeLayer {
    if (!_fadeLayer) {
        _fadeLayer = [CAGradientLayer layer];
        _fadeLayer.locations = @[@(0), @(0.18), @(1-0.18), @(1)];
        _fadeLayer.colors = @[(id)UIColorMakeWithRGBA(255, 255, 255, 0).CGColor, (id)UIColorMakeWithRGBA(255, 255, 255, 1).CGColor, (id)UIColorMakeWithRGBA(255, 255, 255, 1).CGColor, (id)UIColorMakeWithRGBA(255, 255, 255, 0).CGColor];
       
    }
    return _fadeLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.vScrollerView.contentSize = CGSizeMake(0, self.lyrics.count * self.rowHeight);
#warning 必须使用self.bounds.size.height  不能使用self.vScrollerView.bounds.size.height   这个layoutSubviews只作用于self   所以self.vScrollerView可能还没有布局完成
    CGFloat top = (self.bounds.size.height - self.rowHeight) * 0.5;
    CGFloat bottom = top;
    self.vScrollerView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    if (self.fadeLayer) {
        self.fadeLayer.frame = self.bounds;
        self.fadeLayer.position = self.center;
    }
}
#pragma mark UIScrollerView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self vScrollerViewDidScroll];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.vScrollerView) {
#warning 暂时屏蔽掉
        self.sliderView.hidden = NO;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (scrollView == self.vScrollerView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.vScrollerView.isDragging == YES) {
                return ;
            }
            self.sliderView.hidden = YES;
        });
    }
}

/**
 *  水平滚动
 */
- (void)hScrollerViewDidScroll {
    
    CGFloat scrollProgress = self.hScrollerView.contentOffset.x / self.bounds.size.width;
    
    if ([self.delegate respondsToSelector:@selector(lyricView:withProgress:)]) {
        [self.delegate lyricView:self withProgress:scrollProgress];
    }
}

- (void)vScrollerViewDidScroll {
    CGFloat offy = self.vScrollerView.contentOffset.y + self.vScrollerView.contentInset.top;
    NSInteger currentIndex = offy / self.rowHeight;
    if (currentIndex < 0) {
        currentIndex = 0;
    }else if(currentIndex > self.lyrics.count - 1){
        currentIndex = self.lyrics.count - 1;
    }
    FSPLrcModel *lyric = self.lyrics[currentIndex];
    self.sliderView.time = lyric.time;
}


#pragma mark setter和getter
- (void)setLyrics:(NSArray *)lyrics {
    
    _lyrics = lyrics;
    [self.vScrollerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i =0; i < lyrics.count; i ++) {
        
        FSPColorLabel *colorLabel = [[FSPColorLabel alloc] init];
        colorLabel.textColor = [UIColor whiteColor];
        colorLabel.font = [UIFont systemFontOfSize:16];
        FSPLrcModel *lyric = lyrics[i];
        colorLabel.text = lyric.lrc;
        [self.vScrollerView addSubview:colorLabel];
        
        // 添加约束
        [colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.vScrollerView);
            make.top.mas_equalTo(self.rowHeight * i);
            make.height.mas_equalTo(self.rowHeight);
        }];
    }
    
    //    self.vScrollerView.contentSize = CGSizeMake(0, self.lyrics.count * self.rowHeight);
}

- (NSInteger)rowHeight {
    if (_rowHeight == 0) {
        //        _rowHeight = 44;
        _rowHeight = 30;
        
    }
    return _rowHeight;
}


- (void)setCurrentLyricIndex:(NSInteger)currentLyricIndex {
    
    //找出开始出现和消失的位置修改 alpha 0.3  安卓不进行变色
    
    if (currentLyricIndex >= 6){
        FSPColorLabel *preLabel = self.vScrollerView.subviews[currentLyricIndex - 6];
        //        preLabel.alpha  = 0.5;
        preLabel.shouldShowFadeLayer = YES;
    }
    if (self.vScrollerView.subviews.count >= currentLyricIndex + 6 ){
        //        SEMIColorLabel *nextLabel = self.vScrollerView.subviews[currentLyricIndex + 6];
        //        nextLabel.alpha  = 0.5;
        FSPColorLabel *nextLabel = self.vScrollerView.subviews[currentLyricIndex + 6];
        //        preLabel.alpha  = 0.5;
        nextLabel.shouldShowFadeLayer = YES;
        
        FSPColorLabel *nextLastLabel = self.vScrollerView.subviews[currentLyricIndex + 5];
        //        preLabel.alpha  = 0.5;
        nextLastLabel.shouldShowFadeLayer = NO;
        
        
        //        nextLabel.willDisprogress = 0.2;
        FSPColorLabel *lastLabel = self.vScrollerView.subviews[currentLyricIndex + 5];
        lastLabel.alpha  =1;
    }else{
        
    }
    
    // 切歌时数组越界
    FSPColorLabel *preLabel = self.vScrollerView.subviews[self.currentLyricIndex];
    preLabel.progress = 0;
    _currentLyricIndex = currentLyricIndex;
    
    //如果此时在滚动情况 就不定位了
    if (!self.sliderView.hidden) {
        return ;
    }
    NSInteger offY = currentLyricIndex * self.rowHeight - self.vScrollerView.contentInset.top;
    self.vScrollerView.contentOffset = CGPointMake(0, offY);
    [self.vScrollerView setContentOffset:CGPointMake(0, offY) animated:YES];
}

- (NSInteger)currentLyricIndex {
    
    if (_currentLyricIndex <0) {
        _currentLyricIndex = 0;
    }else if(_currentLyricIndex >= self.lyrics.count - 1){
        _currentLyricIndex = self.lyrics.count - 1;
    }
    return _currentLyricIndex;
}

- (void)setLyricProgress:(CGFloat)lyricProgress {
    _lyricProgress = lyricProgress;
    FSPColorLabel *colorLabel = self.vScrollerView.subviews[self.currentLyricIndex];
    colorLabel.progress = lyricProgress;
}

@end
