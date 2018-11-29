//
//  QDGridViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/16.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "QDGridViewController.h"
#import "QDButtonViewController.h"
#import "FSPTextFieldViewController.h"
#import "FSPselfAdaptViewController.h"
#import "SEMIBarcodeScannerViewController.h"
#import "SEMIPlayMusicViewController.h"

@interface QDGridViewController ()

@end

@implementation QDGridViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



#pragma mark - private methonds
- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"QMUIKit";
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithImage:UIImageMake(@"icon_nav_about") target:self action:@selector(handleAboutItemEvent)];
}
- (void)initDataSource {
    self.dataSource = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                                        @"QMUIButton",UIImageMake(@"icon_grid_button"),
                            @"FSPTextField",UIImageMake(@"icon_grid_textField"),
                       @"FSPselfAdaptViewController",UIImageMake(@"icon_grid_textField"),
        @"SEMIBarcodeScannerViewController",UIImageMake(@"icon_grid_textField"),
        @"SEMIPlayMusicViewController",UIImageMake(@"icon_grid_textField"),
                                        nil];
}


- (void)didSelectCellWithTitle:(NSString *)title {
    UIViewController *viewController = nil;

    if ([title isEqualToString:@"QMUIButton"]) {
        viewController = [[QDButtonViewController alloc] init];
    }else if([title isEqualToString:@"FSPTextField"]) {
        viewController = [[FSPTextFieldViewController alloc] init];

    }else if([title isEqualToString:@"FSPselfAdaptViewController"]) {
        viewController = [[FSPselfAdaptViewController alloc] init];
    }else if([title isEqualToString:@"SEMIBarcodeScannerViewController"]) {
        viewController = [[SEMIBarcodeScannerViewController alloc] init];
    }else if([title isEqualToString:@"SEMIPlayMusicViewController"]) {
        viewController = [[SEMIPlayMusicViewController alloc] init];
    }
    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
