//
//  FSPBaseWkwebviewViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/7.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPBaseWkwebviewViewController.h"
#import "KSConstants.h"

@interface FSPBaseWkwebviewViewController ()
{
    BOOL _isTerminateWebView;

}
@end

@implementation FSPBaseWkwebviewViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self applicationWillEnterForeground];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_webView evaluateJavaScriptMethod:k_WebViewDidAppear completionHandler:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    KSWebView *webView = _webView;
    [webView pausePlayingVideo];
    [webView evaluateJavaScriptMethod:k_WebViewDidDisappear completionHandler:nil];
}

-(void)loadView {
    [super loadView];
    _isTerminateWebView = NO;
    KSWebView *webView = [self loadWebView];
    __weak typeof(self) weakSelf = self;
    [webView setWebViewTitleChangedCallback:^(NSString *title) {
        if (title.length != 0) {
            weakSelf.title = title;
        }
    }];
    _webView = webView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"正在加载...";
}

-(KSWebView*)loadWebView {
    KSWebView *webView = [KSWebView safelyReleaseWebViewWithFrame:self.view.frame delegate:self];
    self.view = webView;
    return webView;
}

-(void)startWebViewRequest {
    if (_url.length != 0) {
        [_webView loadWebViewWithURL:_url params:_params];
    } else if (_filePath.length != 0) {
        [_webView loadWebViewWithFilePath:_filePath];
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(KSWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"error=%@",error.localizedDescription);
    [webView resetProgressView];
}

- (void)webViewWebContentProcessDidTerminate:(KSWebView *)webView {
    _isTerminateWebView = YES;
}

-(void)applicationWillEnterForeground {
    if (_isTerminateWebView) {
        _isTerminateWebView = NO;
        [self loadWebView];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}
@end
