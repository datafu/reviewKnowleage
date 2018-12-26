//
//  FSPPopUpViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/21.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPPopUpViewController.h"
#import "FSPFSPPopupContainerView.h"
@interface FSPPopUpViewController ()

// 定义参考按钮
@property(nonatomic, strong) QMUIButton *button;

@property(nonatomic, strong) FSPFSPPopupContainerView *customPopView;
@end

@implementation FSPPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubviews {
    [super initSubviews];
    self.button = [QDUIHelper generateDarkFilledButton];
    [self.button addTarget:self action:@selector(handleButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:@"显示自定义浮层" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    self.customPopView = [[FSPFSPPopupContainerView alloc] init];
    self.customPopView.preferLayoutDirection =  QMUIPopupContainerViewLayoutDirectionBelow;
//    [self.customPopView.popCustomview.collectBtn addTarget:self action:@selector(clickCollect) forControlEvents:UIControlEventTouchUpInside];

    self.customPopView.automaticallyHidesWhenUserTap = YES;// 点击空白地方消失浮层
    self.customPopView.backgroundColor = [[UIColor qmui_colorWithHexString:@"#737592"] colorWithAlphaComponent:0.9] ;
//    self.customPopView.maskViewBackgroundColor = UIColorMaskWhite;// 使用方法 2 并且打开了 automaticallyHidesWhenUserTap 的情况下，可以修改背景遮罩的颜色
    __weak __typeof(self)weakSelf = self;
    self.customPopView.didHideBlock = ^(BOOL hidesByUserTap) {
        [weakSelf.button setTitle:@"显示自定义浮层" forState:UIControlStateNormal];
        
    };
}

- (void)clickCollect {
    QMUILog(@"",@"");
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    CGFloat minY = self.qmui_navigationBarMaxYInViewCoordinator;

    self.button.frame = CGRectSetXY(self.button.frame,
      CGRectGetMinXHorizontallyCenterInParentRect(self.view.bounds, self.button.frame), CGRectGetHeight(self.view.frame) / 2.0);
  
    [self.customPopView layoutWithTargetRectInScreenCoordinate:[self.button convertRect:self.button.bounds toView:nil]];// 将 button 的坐标转换到相对于 UIWindow 的坐标系里，然后再传给浮层布局

}


- (void)handleButtonEvent:(QMUIButton *)button {
    
    if (button == self.button) {
        if (self.customPopView.isShowing) {
            [self.customPopView hideWithAnimated:YES];
        } else {
            [self.customPopView showWithAnimated:YES];
            [self.button setTitle:@"隐藏自定义浮层" forState:UIControlStateNormal];
        }
        return;
    }
}
@end
