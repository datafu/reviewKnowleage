//
//  FSPTestWkwebviewViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/7.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPTestWkwebviewViewController.h"

@interface FSPTestWkwebviewViewController ()

@end

@implementation FSPTestWkwebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KSWebViewScriptHandler *testJSCallback  = [KSWebViewScriptHandler scriptHandlerWithTarget:self action:@selector(webViewScriptHandlerTestJSCallbackWithMessage:)];
    KSWebViewScriptHandler *testReturnValue = [KSWebViewScriptHandler scriptHandlerWithTarget:self action:@selector(webViewScriptHandlerTestReturnValue)];
    KSWebViewScriptHandler *alert           = [KSWebViewScriptHandler scriptHandlerWithTarget:self action:@selector(webViewScriptHandlerAlertWithMessage:)];
    KSWebViewScriptHandler *openNewPage     = [KSWebViewScriptHandler scriptHandlerWithTarget:self action:@selector(webViewScriptHandlerOpenNewPage)];
    self.webView.scriptHandlers = @{@"testJSCallback" :testJSCallback,
                                    @"testReturnValue":testReturnValue,
                                    @"alert"          :alert,
                                    @"openNewPage"    :openNewPage};
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    self.filePath = path;
    [self startWebViewRequest];
}
-(KSWebView *)loadWebView {
    KSWebView *webView = [super loadWebView];
    UIScrollView *scrollView = webView.scrollView;
    CGFloat top = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    scrollView.contentInset = (UIEdgeInsets){top,0.f,0.f,0.f};//复杂的Html中不建议设置此项会影响布局
    return webView;
}

-(void)webViewScriptHandlerTestJSCallbackWithMessage:(WKScriptMessage*)message {
    NSLog(@"JS调用了客户端的方法!");
    [self.webView evaluateJavaScriptMethod:@"callback','客户端调用js" completionHandler:^(id returnValue, NSError *error) {
        NSLog(@"JS调用了客户端的方法返回值%@",returnValue);
    }];
}

//return的值 务必转成String
-(NSString*)webViewScriptHandlerTestReturnValue {
    return @"拿到客户端反回的值啦!!";
}

-(void)webViewScriptHandlerAlertWithMessage:(WKScriptMessage*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"来自网页的信息" message:message.body preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)webViewScriptHandlerOpenNewPage {
    FSPTestWkwebviewViewController *controller = [[FSPTestWkwebviewViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
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
