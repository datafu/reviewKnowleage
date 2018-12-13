//
//  FSPTestgithubViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/7.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPTestgithubViewController.h"

@interface FSPTestgithubViewController ()

@end

@implementation FSPTestgithubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startWebViewRequest];
}

-(KSWebView *)loadWebView {
    KSWebView *webView = [[KSWebView alloc] initWithFrame:self.view.frame delegate:self];
    self.view = webView;
    UIScrollView *scrollView = webView.scrollView;
    CGFloat top = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    scrollView.contentInset = (UIEdgeInsets){top,0.f,0.f,0.f};//复杂的Html中不建议设置此项会影响布局
    return webView;
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
