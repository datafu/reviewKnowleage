//
//  FSPNavMainViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPNavMainViewController.h"
#import "FSPMapMainNavigationView.h"
#import "FSPNormalBUtton.h"
@interface FSPNavMainViewController ()
@property(nonatomic, strong) FSPMapMainNavigationView *navView;
@property (weak, nonatomic) IBOutlet FSPNormalBUtton *aroundButton;

@end

@implementation FSPNavMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    [self initMapView];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden= YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden= NO;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
- (void)setupNavigationItems {
    // 子类重写
    [super setupNavigationItems];
   
}
#pragma mark - QMUINavigationControllerDelegate
- (UIImage *)navigationBarBackgroundImage {
    
        return [UIImage qmui_imageWithColor:[UIColor blackColor]];
    
}

#pragma mark - setting and getting
- (FSPMapMainNavigationView*)navView {
    if (!_navView) {
        _navView = [[FSPMapMainNavigationView alloc] init];
        _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    }
    return _navView;
}
@end
