//
//  FSPUsingExampleGridViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/7.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPUsingExampleGridViewController.h"
#import "FSPselfAdaptViewController.h"
#import "SEMIBarcodeScannerViewController.h"
#import "SEMIPlayMusicViewController.h"
#import "FSPTimePickerViewController.h"
#import "FSPInnerOuternerProgressRingViewController.h"
#import "FSPTestWkwebviewViewController.h"
#import "FSPDragTableviewController.h"
#import "FSPFoldingUnfoldingViewController.h"
#import "FSPYYKitDemoViewController.h"
#import "FSPNavBaseViewController.h"
#import "FSPNavMainViewController.h"
#import "FSPLoginViewController.h"
#import "FSPScrollTestViewController.h"
#import "FSPSwitchScrollviewViewController.h"
#import "FSPPopUpViewController.h"
#import "FSPTouchSubScrollViewController.h"

@implementation FSPUsingExampleGridViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - private methonds
- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"UsingExample";
}
- (void)initDataSource {
    self.dataSource = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                       @"FSPselfAdaptViewController",UIImageMake(@"icon_grid_textField"),
                @"SEMIBarcodeScannerViewController",UIImageMake(@"icon_grid_textField"),
                    @"SEMIPlayMusicViewController",UIImageMake(@"icon_grid_textField"),
                    @"FSPTimePickerViewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPInnerOuternerProgressRingViewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPTestWkwebviewViewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPDragTableviewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPFoldingUnfoldingViewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPYYKitDemoViewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPNavMainViewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPLoginViewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPScrollTestViewController",UIImageMake(@"icon_grid_textField"),
                        @"FSPSwitchScrollviewViewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPPopUpViewController",UIImageMake(@"icon_grid_textField"),
                       @"FSPTouchSubScrollViewController",UIImageMake(@"icon_grid_textField"),
                       
                       nil];
}


- (void)didSelectCellWithTitle:(NSString *)title {
    UIViewController *viewController = nil;
    if([title isEqualToString:@"FSPselfAdaptViewController"]) {
        viewController = [[FSPselfAdaptViewController alloc] init];
    }else if([title isEqualToString:@"SEMIBarcodeScannerViewController"]) {
        viewController = [[SEMIBarcodeScannerViewController alloc] init];
    }else if([title isEqualToString:@"SEMIPlayMusicViewController"]) {
        viewController = [[SEMIPlayMusicViewController alloc] init];
    }else if([title isEqualToString:@"FSPTimePickerViewController"]) {
        viewController = [[FSPTimePickerViewController alloc] init];
    }else if([title isEqualToString:@"FSPInnerOuternerProgressRingViewController"]) {
        viewController = [[FSPInnerOuternerProgressRingViewController alloc] init];
    }else if([title isEqualToString:@"FSPTestWkwebviewViewController"]) {
        viewController = [[FSPTestWkwebviewViewController alloc] init];
    }else if([title isEqualToString:@"FSPDragTableviewController"]) {
        viewController = [[FSPDragTableviewController alloc] init];
    }else if([title isEqualToString:@"FSPFoldingUnfoldingViewController"]) {
        viewController = [[FSPFoldingUnfoldingViewController alloc] init];
    }else if([title isEqualToString:@"FSPYYKitDemoViewController"]) {
        viewController = [[FSPYYKitDemoViewController alloc] init];
    }else if([title isEqualToString:@"FSPNavMainViewController"]) {
        viewController = [[FSPNavMainViewController alloc] init];
    }else if([title isEqualToString:@"FSPLoginViewController"]) {
        viewController = [[FSPLoginViewController alloc] init];
    }else if([title isEqualToString:@"FSPScrollTestViewController"]) {
        viewController = [[FSPScrollTestViewController alloc] init];
    }else if([title isEqualToString:@"FSPSwitchScrollviewViewController"]) {
        viewController = [[FSPSwitchScrollviewViewController alloc] init];
    }else if([title isEqualToString:@"FSPPopUpViewController"]) {
        viewController = [[FSPPopUpViewController alloc] init];
    }else if([title isEqualToString:@"FSPTouchSubScrollViewController"]) {
        viewController = [[FSPTouchSubScrollViewController alloc] init];
    }
    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
