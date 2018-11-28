//
//  BaseCommonTableViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/15.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "BaseCommonTableViewController.h"

@interface BaseCommonTableViewController ()

@end

@implementation BaseCommonTableViewController
- (void)didInitialize {
    [super didInitialize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChangedNotification:) name:QDThemeChangedNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)handleThemeChangedNotification:(NSNotification *)notification {
    NSObject<QDThemeProtocol> *themeBeforeChanged = notification.userInfo[QDThemeBeforeChangedName];
    themeBeforeChanged = [themeBeforeChanged isKindOfClass:[NSNull class]] ? nil : themeBeforeChanged;
    
    NSObject<QDThemeProtocol> *themeAfterChanged = notification.userInfo[QDThemeAfterChangedName];
    themeAfterChanged = [themeAfterChanged isKindOfClass:[NSNull class]] ? nil : themeAfterChanged;
    
    [self themeBeforeChanged:themeBeforeChanged afterChanged:themeAfterChanged];
}

#pragma mark - <QDChangingThemeDelegate>

- (void)themeBeforeChanged:(NSObject<QDThemeProtocol> *)themeBeforeChanged afterChanged:(NSObject<QDThemeProtocol> *)themeAfterChanged {
    [self.tableView reloadData];
}

@end
