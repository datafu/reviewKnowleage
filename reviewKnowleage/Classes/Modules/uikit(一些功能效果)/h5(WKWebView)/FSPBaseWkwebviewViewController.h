//
//  FSPBaseWkwebviewViewController.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/7.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "BaseCommonViewController.h"
#import "KSWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSPBaseWkwebviewViewController :BaseCommonViewController<WKNavigationDelegate>

@property (nonatomic, weak, readonly) KSWebView *webView;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSDictionary *params;

//初始化时调用布局KSWebView,默认全屏(self.view = webView)
-(KSWebView*)loadWebView;
//开始WebView请求，继承后手动调用
-(void)startWebViewRequest;

//页面加载失败之后调用//此方法中有实现需执行super方法
- (void)webView:(KSWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
