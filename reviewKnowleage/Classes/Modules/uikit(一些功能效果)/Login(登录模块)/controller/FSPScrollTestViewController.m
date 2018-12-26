//
//  FSPScrollTestViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/14.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPScrollTestViewController.h"
#import "JXCategoryTitleView.h"
#import "JXCategoryIndicatorLineView.h"
#import "FSPPasswordView.h"
#import "FSPSmsCodeView.h"
@interface FSPScrollTestViewController ()
//指示器
@property(nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@end

@implementation FSPScrollTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.titleSelectedColor  =  [QDThemeManager sharedInstance].currentTheme.themeTintColor;
    self.myCategoryView.titles = self.titles;
    self.lineView.indicatorLineWidth = 120;
    self.myCategoryView.indicators = @[self.lineView];
    self.lineView.indicatorLineViewColor = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
//    self.myCategoryView.qmui_borderPosition = QMUIViewBorderPositionBottom;
}

- (void)didInitialize {
    [super didInitialize];
}
- (void)initSubviews {
    [super initSubviews];
    
}
- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}
/*滚动视图title 宽度*/
- (CGFloat)preferredCategoryViewWidth {
    return  300;
}

//- (CGFloat)preferredScrollViewHeight {
//    return  300;
//}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleView class];
}

// 重写添加view 到scrollview 
- (void)loadSubviewToScrollview {
    NSUInteger count = [self preferredListViewCount];
    CGFloat width = [self preferredCategoryViewWidth];
    CGFloat height = [self preferredScrollViewHeight];
    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];
    CGFloat naviHeight = self.qmui_navigationBarMaxYInViewCoordinator;
    if (height == 0 ) {
        height = SCREEN_HEIGHT - naviHeight - categoryViewHeight;
    }
//    for (int i = 0; i < count; i ++) {
//
//        UIView * view = [UIView new];
//        view.frame = CGRectMake(i*width, 0, width, height);
//        view.backgroundColor = [QDCommonUI randomThemeColor ];
//        [self.scrollView addSubview:view];
//    }
    FSPSmsCodeView  * codeView = [[FSPSmsCodeView alloc] init];
    codeView.frame = CGRectMake(0, 0, width, height);
    FSPPasswordView * passwordView = [[FSPPasswordView alloc] init];
    passwordView.frame = CGRectMake(width, 0, width, height);
    [self.scrollView addSubview:codeView];
    [self.scrollView addSubview:passwordView];
}

#pragma mark - private methods


#pragma mark - setting and getting
- (NSArray*)titles {
    if (_titles == nil) {
        _titles = @[@"验证码登录", @"密码登录"];
    }
    return  _titles;
}

- (JXCategoryIndicatorLineView *)lineView {
    if (!_lineView) {
        _lineView = [[JXCategoryIndicatorLineView alloc] init];
    }
    return _lineView;
}


@end
