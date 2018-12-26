//
//  QDCommonGridViewController.h
//  reviewKnowleage
//
//  Created by fushp on 2018/10/15.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "QMUICommonViewController.h"

@interface QDCommonGridViewController : QMUICommonViewController

@property(nonatomic, strong) QMUIOrderedDictionary<NSString*, UIImage* > *dataSource;
@property(nonatomic, strong) QMUIGridView *gridView;

@end



@interface QDCommonGridViewController (UISubclassingHooks)

// 子类继承，可以不调super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(NSString *)title;
@end

