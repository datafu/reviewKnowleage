//
//  FSPSwitchScrollviewViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/14.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPSwitchScrollviewViewController.h"
#import "JXCategoryTitleView.h"
#import "JXCategoryIndicatorLineView.h"
@interface FSPSwitchScrollviewViewController ()
//指示器
@property(nonatomic, strong) JXCategoryIndicatorLineView *lineView;
@end

@implementation FSPSwitchScrollviewViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.titleSelectedColor  =  [QDThemeManager sharedInstance].currentTheme.themeTintColor;
    self.myCategoryView.titles = self.titles;
//    self.lineView.indicatorLineWidth = 120;
//    self.myCategoryView.indicators = @[self.lineView];
//    self.lineView.indicatorLineViewColor = [QDThemeManager sharedInstance].currentTheme.themeTintColor;
//
    self.categoryView.frame = CGRectMake(0, 0, 300, 64);
    
    self.myCategoryView.titles = self.titles;
//    self.myCategoryView.cellSpacing = 90;
//    self.myCategoryView.cellWidth = 120;
    
//    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
//    backgroundView.backgroundViewHeight = 30;
//    backgroundView.backgroundViewWidthIncrement = 0;
//    backgroundView.backgroundViewColor = [UIColor redColor];
//    self.myCategoryView.indicators = @[backgroundView];
    
    [self.myCategoryView removeFromSuperview];
    self.navigationItem.titleView = self.myCategoryView;
}

//获取切换栏对象
- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

// title 指定一个对象
- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleView class];
}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

#pragma mark - private methods


#pragma mark - setting and getting
- (NSArray*)titles {
    if (_titles == nil) {
        _titles = @[@"新闻", @"活动"];
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
