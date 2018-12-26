//
//  BaseCommonListViewController.h
//  reviewKnowleage
//
//  Created by fushp on 2018/10/16.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCommonTableViewController.h"
@interface BaseCommonListViewController : BaseCommonTableViewController
@property(nonatomic, strong) NSArray<NSString *> *dataSource;
@property(nonatomic, strong) QMUIOrderedDictionary<NSString *, NSString *> *dataSourceWithDetailText;

@end


@interface BaseCommonListViewController (UISubclassingHooks)

// 子类继承，可以不调super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(NSString *)title;

@end

