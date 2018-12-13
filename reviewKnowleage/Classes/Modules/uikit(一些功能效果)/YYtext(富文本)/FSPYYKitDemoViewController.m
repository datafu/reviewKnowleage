//
//  FSPYYKitDemoViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/11.
//  Copyright © 2018年 fushp. All rights reserved.
//   text： 我已阅读并同意 《 免责协议》

#import "FSPYYKitDemoViewController.h"
#import <YYText.h>
@interface FSPYYKitDemoViewController ()
@property(nonatomic, strong)  YYLabel * yyLabel;
@end

@implementation FSPYYKitDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftView_rightText];
    // Do any additional setup after loading the view.
}

- (void)leftView_rightText {
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:16];
    {
        NSString *title = @"This is UIView attachment: ";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
        
        UISwitch *switcher = [UISwitch new];
        [switcher sizeToFit];
        NSMutableAttributedString * attachText = [ NSMutableAttributedString yy_attachmentStringWithContent:switcher contentMode:UIViewContentModeCenter attachmentSize:switcher.frame.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
        [text yy_setTextHighlightRange:NSMakeRange(0, 4)
                                color:nil
                      backgroundColor:nil
                            tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                QMUILogInfo(@"text",@"点击了");
                            }];
        
    }
    self.yyLabel = [YYLabel new];
    self.yyLabel.attributedText = text;
    self.yyLabel.textAlignment = NSTextAlignmentCenter;
    self.yyLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    self.yyLabel.numberOfLines = 0;
    self.yyLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.yyLabel];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat contentMinY = self.qmui_navigationBarMaxYInViewCoordinator;

    self.yyLabel.frame = CGRectMake(20, contentMinY+20, self.view.frame.size.width -100, 30);
}
@end
