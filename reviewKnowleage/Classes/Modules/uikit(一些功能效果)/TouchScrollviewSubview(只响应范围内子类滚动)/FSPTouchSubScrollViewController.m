//
//  FSPTouchSubScrollViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/26.
//  Copyright © 2018年 fushp. All rights reserved.
//




#import "FSPTouchSubScrollViewController.h"
#import <UIScrollView+MJRefresh.h>
#import <MJRefresh.h>
#import "FSPUIScrollView.h"
#import "FSPSubView.h"
@interface FSPTouchSubScrollViewController ()

@property(nonatomic, strong) FSPUIScrollView *scrollview;
@property(nonatomic, strong) FSPSubView *transformImageView;
@property(nonatomic, strong) QMUILabel *label;
@end

@implementation FSPTouchSubScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)didInitialize {
    [super didInitialize];
}

- (void)initSubviews {
    [super initSubviews];
    self.label = [[QMUILabel alloc] init];
    self.label.text = @"本demo效果是在指针里面不响应scroview 的滚动效果在指针区域外可响应它的滚动效果,该效果由canCancelContentTouches 和 delaysContentTouches 决定";
    self.label.numberOfLines = 0;//表示label可以多行显示
    [self.label sizeToFit];
    [self.view addSubview:self.label];
    self.scrollview = [[FSPUIScrollView alloc] init];
    [self.view addSubview:self.scrollview];
    
//    self.transformImageView = [[UIImageView alloc] initWithImage:UIImageMake(@"btn_rotate")];
//    [self.scrollview addSubview:self.transformImageView];
//    self.transformImageView.userInteractionEnabled = YES;
    //将事件及时传递
    self.scrollview.delaysContentTouches = NO;
    
    //yes 判断是否要启动滚动事件 no 不启动滚动事件
    self.scrollview.canCancelContentTouches = NO;
    self.transformImageView = [[FSPSubView alloc]init];
    self.transformImageView.backgroundColor = [UIColor yellowColor];
    self.transformImageView.userInteractionEnabled = YES;
    [self.scrollview addSubview:self.transformImageView];
    [self addRefresh];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollview.frame = self.view.bounds;
    CGFloat offy= self.qmui_navigationBarMaxYInViewCoordinator;
    CGFloat x = CGFloatGetCenter(SCREEN_WIDTH, 300);
    self.label.frame = CGRectMake(x , offy, 300, 100);
//    self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    //设置居中
    self.transformImageView.frame = CGRectMake(CGFloatGetCenter(SCREEN_WIDTH, 240),300, 240, 240);
}
// 添加下拉刷新
- (void)addRefresh{
    
    __weak __typeof(self)weakSelf = self;
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        QMUILogInfo(@"refresh",@"下拉刷新");
        [weakSelf refresh];
        
    }];
    [mj_header setTitle:kRefreshStateIdle forState:MJRefreshStateIdle];
    [mj_header setTitle:kRefreshStatePulling forState:MJRefreshStatePulling];
    [mj_header setTitle:kRefreshStateRefreshing forState:MJRefreshStateRefreshing];
    
    self.scrollview.mj_header = mj_header;
    
}

//
- (void)refresh {
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.scrollview.mj_header endRefreshing];

    });
}


@end
