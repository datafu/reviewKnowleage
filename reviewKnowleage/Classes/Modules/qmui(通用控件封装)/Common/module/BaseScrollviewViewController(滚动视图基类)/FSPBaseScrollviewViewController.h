//
//  FSPBaseScrollviewViewController.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/14.
//  Copyright © 2018年 fushp. All rights reserved.
//
/*
 描述:
   内置滚动视图view
    怎么在导航栏加入 滚动视图
 
 */

#import "BaseCommonViewController.h"
NS_ASSUME_NONNULL_BEGIN
@class JXCategoryBaseView;
@interface FSPBaseScrollviewViewController : BaseCommonViewController
@property (nonatomic, strong) JXCategoryBaseView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL shouldHandleScreenEdgeGesture;

/*滚动视图对象*/
- (Class)preferredCategoryViewClass;

/*滚动视图 title 数量*/
- (NSUInteger)preferredListViewCount;

/*滚动视图title 高度*/
- (CGFloat)preferredCategoryViewHeight;

/*滚动视图title 宽度*/
- (CGFloat)preferredCategoryViewWidth;

/*滚动视图title y轴坐标 */
- (CGFloat)preferredCategoryViewY;


/*scrollview 高度  不设置 充满屏幕以下 */
- (CGFloat)preferredScrollViewHeight;

/* scrollview加载的class */
- (Class)preferredListViewControllerClass;


/*添加scrollview view */
- (void)loadSubviewToScrollview:(NSInteger)count width:(CGFloat)width height:(CGFloat)height  categoryViewHeight:(CGFloat)categoryViewHeight;
- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index;


@end

NS_ASSUME_NONNULL_END
