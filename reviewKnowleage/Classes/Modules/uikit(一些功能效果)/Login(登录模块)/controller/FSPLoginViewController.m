//
//  FSPLoginViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPLoginViewController.h"
#import "FSPEditTextField.h"
#import "FSPTextField.h"
#import "FSPUserMangager.h"
#import "FSPNetworkTools.h"
#import "FSPUserInfo.h"
@interface FSPLoginViewController ()<QMUITextFieldDelegate>
//@property(nonatomic, strong) FSPTextField *userPassword;
@property (strong, nonatomic) IBOutlet FSPCountdownButton *countDownBtn;
@property (weak, nonatomic) IBOutlet FSPEditTextField *userEditView;

@end

@implementation FSPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
}
- (void)initSubviews {
    [super initSubviews];
    __weak __typeof(self)weakSelf = self;
    self.userEditView.fspEditTextFieldRightButtonClick = ^(UIButton * _Nonnull btn) {
        [weakSelf loginReq];
    };
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    CGFloat y = self.qmui_navigationBarMaxYInViewCoordinator;
//    self.userPassword.frame = CGRectMake(15, y+ 20, 200, 60);
    
    
}

#pragma mark - network request
- (void)loginReq {
    
    [FSPNetworkTools post:kappLoginAuthenUrl andPragram:@{} modelName:@"FSPUserInfo" modelType:0 successBlock:^(id  _Nonnull model) {
        
        userManager.curUserInfo = model;
        
    } failBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull error) {
        
    }];
}


@end
