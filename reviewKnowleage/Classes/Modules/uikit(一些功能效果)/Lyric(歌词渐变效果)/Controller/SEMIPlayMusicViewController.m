//
//  SEMIPlayMusicViewController.m
//  SEMI-IV
//
//  Created by 杨俊杰 on 2018/8/15.
//  Copyright © 2018年 soueast-motor. All rights reserved.
//

#import "SEMIPlayMusicViewController.h"




#import <Masonry/Masonry.h>

#import <QMUIKit/UIColor+QMUI.h>
#import "FSPLyricView.h"
#import "FSPLrcModel.h"
#import "NSDateFormatter+FSPNSDateShared.h"

@interface SEMIPlayMusicViewController ()<FSPLyricViewDelegate>

/** 背景图片 */
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
/** 返回 */
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
/** 收藏 */
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
/** 歌名 */
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
/** 歌词View */
@property (weak, nonatomic) IBOutlet UIView *lyricView;
/** 歌词数组 */
@property (nonatomic, strong) NSArray *lrcArray;


/** 底部控制View容器 */
@property (weak, nonatomic) IBOutlet UIView *musicBarView;
/** 底部控制View */
@property (nonatomic,strong) UIView *musicBar;
/** 播放菜单View */
@property (nonatomic, strong) UIView *meanView;

/** 播放数据数组 */
@property (nonatomic,strong) NSArray *dataArray;
/** 当前播放的id */
@property (nonatomic,copy) NSString *currentPlayID;

/** 当前播放的索引 */
@property (nonatomic,assign) NSInteger currentIndex;

/** 播放模式 */
@property (nonatomic,assign) PlayerMode playMode;
/** 播放列表数组 */
@property (nonatomic, strong) NSMutableArray *df_ModelArray;

/** 歌词展示uiview */
@property (nonatomic, strong) FSPLyricView *lrcView;

/** 当前行 *///currentLrcIndex
@property (nonatomic,assign) NSInteger currentLrcIndex;
/** 当前歌曲总时间 */
@property (nonatomic,assign) NSTimeInterval duration;
/** 当前播放时间 */
@property (nonatomic,assign) NSTimeInterval currentTime;

@property (assign, nonatomic) CGPoint beginpoint;

@end

@implementation SEMIPlayMusicViewController

/** 实例化方法 */
+ (instancetype)sharedInstance
{
    static SEMIPlayMusicViewController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SEMIPlayMusicViewController alloc] init];
    });
    return instance;
}
- (BOOL)willDealloc {
    return NO;
}
- (FSPLyricView*)lrcView {
    if (!_lrcView) {
        _lrcView = [[FSPLyricView alloc] init];
        _lrcView.delegate = self;
//        _lrcView.rowHeight = 44.0;
        _lrcView.rowHeight = 34.0;
    }
    return _lrcView;
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initSubviews ];
    
    //默认暂停状态
    self.isPlaying = NO;
    //获取歌词 展示歌词
    [self requestLyricWithSongId];

}



#pragma mark -- 初始化视图
- (void)initSubviews{
//    [super initSubviews];
    
  
    //歌词View添加
    [self.lyricView addSubview:self.lrcView];
    
    //添加渐变层
    
    [self.lrcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.lyricView);
    }];

    // 添加下滑的手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popView)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:recognizer];
    
}


#pragma mark --点击歌词加载按钮跳转到特定时间播放
- (void)lyricView:(NSTimeInterval)SetTime {
    NSLog(@"歌词加载按钮跳转到特定时间播放:%f",SetTime);
//    self.musicBar.currentTime = [SEMITimeDataString timeStrWithSecTime:(SetTime)];
//    kPlayerTool.progress = SetTime;
    // 如果没有在播放的话 就自动播放
    if (!self.isPlaying) {
        NSLog(@"---555---%s",__func__);
//        [kPlayerTool playMusic];
    }
}

#pragma mark - 歌词滚动
// 重写time的setter
- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    if (self.currentLrcIndex >= self.lrcArray.count) {
        return;
    }
    FSPLrcModel *lyric = self.lrcArray[self.currentLrcIndex];
    FSPLrcModel *nextLyric = nil;
    if (self.currentLrcIndex >= self.lrcArray.count - 1) {
        nextLyric = [[FSPLrcModel alloc] init];
        nextLyric.time = currentTime;
    }else{
        nextLyric = self.lrcArray[self.currentLrcIndex + 1];;
    }
    if (currentTime < lyric.time && self.currentLrcIndex > 0) {
        self.currentLrcIndex --;
        return;
    }else if(currentTime >= nextLyric.time && self.currentLrcIndex < self.lrcArray.count - 1){
        self.currentLrcIndex ++;
        return;
    }
    
    // 设置歌词颜色 -->该方法 进行逐字显示
//    CGFloat progress = (currentTime - lyric.time) / (nextLyric.time - lyric.time);
//    if (self.currentLrcIndex == self.lrcArray.count - 1) {
//        progress = (currentTime - lyric.time) / (self.duration - lyric.time);
//    }
    //
    self.lrcView.currentLyricIndex = self.currentLrcIndex;
    self.lrcView.lyricProgress = 1;

//    self.lrcView.lyricProgress = progress;
}

#pragma mark -- 歌词获取
- (void)requestLyricWithSongId{
//     self.lrcArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SongWords.plist" ofType:nil]];
    NSError * error;
 NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"];
    NSString *urlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    self.lrcArray = [wslAnalyzer parserLyricWithFileName:urlStr];
    if (self.lrcArray.count == 0) {
        return;
    }
    self.lrcView.lyrics = self.lrcArray;
    self.lrcView.currentLyricIndex = 0;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 返回上一层视图
- (IBAction)backBtnClick:(id)sender {
    
    [self popView];
    
}


#pragma mark -- 收藏
- (IBAction)collectBtnClick:(UIButton *)sender {
   
}

//返回上一层视图
- (void)popView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}







@end
