//
//  BaseCommonGroupListViewController.h
//  reviewKnowleage
//
//  Created by fushp on 2018/10/16.
//  Copyright © 2018年 fushp. All rights reserved.
//  分组列表


#import <UIKit/UIKit.h>
#import "BaseCommonTableViewController.h"

@interface BaseCommonGroupListViewController : BaseCommonTableViewController
@property(nonatomic, strong) QMUIOrderedDictionary *dataSource;

- (NSString *)titleForSection:(NSInteger)section;
- (NSString *)keyNameAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseCommonGroupListViewController (UISubclassingHooks)

// 子类继承，可以不调 super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(NSString *)title;

@end

