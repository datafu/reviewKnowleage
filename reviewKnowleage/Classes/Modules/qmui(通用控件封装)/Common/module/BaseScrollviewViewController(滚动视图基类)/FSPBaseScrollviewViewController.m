//
//  FSPBaseScrollviewViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/14.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPBaseScrollviewViewController.h"
#import <JXCategoryView.h>

@interface FSPBaseScrollviewViewController () <JXCategoryViewDelegate, UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation FSPBaseScrollviewViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldHandleScreenEdgeGesture = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubviews {
    [super initSubviews] ;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat naviHeight = self.qmui_navigationBarMaxYInViewCoordinator;
    
    NSUInteger count = [self preferredListViewCount];
    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];
    CGFloat width = [self preferredCategoryViewWidth];
//    CGFloat height = SCREEN_HEIGHT - naviHeight - categoryViewHeight;
    CGFloat height = [self preferredScrollViewHeight];
    CGFloat x = (SCREEN_WIDTH - width)/2;
    CGFloat y =  [self preferredCategoryViewY];
    if (height == 0 ) { //表示充满整个屏幕
        height = SCREEN_HEIGHT - naviHeight;
        y = 0;
        x = 0;
        categoryViewHeight = 0;
        width = SCREEN_WIDTH;
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y + categoryViewHeight , width, height)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self loadSubviewToScrollview:count width:width height:height categoryViewHeight:categoryViewHeight];
//    for (int i = 0; i < count; i ++) {
//        UIViewController *listVC = [[[self preferredListViewControllerClass] alloc] init];
//        [self configListViewController:listVC index:i];
//        [self addChildViewController:listVC];
//        listVC.view.frame = CGRectMake(i*width, 0, width, height);
//        listVC.view.backgroundColor = [QDCommonUI randomThemeColor ];
//        [self.scrollView addSubview:listVC.view];
//
//    }
    self.categoryView.frame = CGRectMake(x, y, width, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.contentScrollView = self.scrollView;
//    self.categoryView.qmui_borderPosition = QMUIViewBorderPositionBottom;
  
    [self.view addSubview:self.categoryView];
    
}
#pragma mark - private methods
- (Class)preferredCategoryViewClass {
    return [JXCategoryBaseView class];
}

- (NSUInteger)preferredListViewCount {
    return 0;
}

- (CGFloat)preferredCategoryViewHeight {
    return 50;
}
/*滚动视图title 宽度*/
- (CGFloat)preferredCategoryViewWidth {
    return  300;
}
- (CGFloat)preferredCategoryViewY {
    return  215;
}

- (CGFloat)preferredScrollViewHeight{
    return 0;
}
- (Class)preferredListViewControllerClass {
    return [UIViewController class];
}

- (void)loadSubviewToScrollview:(NSInteger)count width:(CGFloat)width height:(CGFloat)height  categoryViewHeight:(CGFloat)categoryViewHeight {
//    NSUInteger count = [self preferredListViewCount];
//    CGFloat width = [self preferredCategoryViewWidth];
//    CGFloat height = [self preferredScrollViewHeight];
//    CGFloat categoryViewHeight = [self preferredCategoryViewHeight];
//    CGFloat naviHeight = self.qmui_navigationBarMaxYInViewCoordinator;
    if (height == 0 ) {
        height = SCREEN_HEIGHT  - categoryViewHeight;
    }
    for (int i = 0; i < count; i ++) {
        UIViewController *listVC = [[[self preferredListViewControllerClass] alloc] init];
        [self configListViewController:listVC index:i];
        [self addChildViewController:listVC];
        listVC.view.frame = CGRectMake(i*width, 0, width, height);
        listVC.view.backgroundColor = [QDCommonUI randomThemeColor ];
        [self.scrollView addSubview:listVC.view];
        
    }

}

- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index {
    
}

- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [[[self preferredCategoryViewClass] alloc] init];
    }
    return _categoryView;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if ([self isKindOfClass:[NestViewController class]]) {
//        CGFloat index = scrollView.contentOffset.x/scrollView.bounds.size.width;
//        CGFloat absIndex = fabs(index - self.currentIndex);
//        if (absIndex >= 1) {
//            //嵌套使用的时候，最外层的VC持有的scrollView在翻页之后，就断掉一次手势。解决快速滑动的时候，只响应最外层VC持有的scrollView。子VC持有的scrollView却没有响应
//            self.scrollView.panGestureRecognizer.enabled = NO;
//            self.scrollView.panGestureRecognizer.enabled = YES;
//            _currentIndex = floor(index);
//        }
//    }
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    if (_shouldHandleScreenEdgeGesture) {
        self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    }
    QMUILog(@"",@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    QMUILog(@"",@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    QMUILog(@"",@"%@", NSStringFromSelector(_cmd));
}

@end
