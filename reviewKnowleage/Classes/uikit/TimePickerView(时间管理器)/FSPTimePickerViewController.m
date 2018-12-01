//
//  FSPTimePickerViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/30.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPTimePickerViewController.h"
#import "FSPTimePickerView.h"

@interface FSPTimePickerViewController ()<FSPTimePickerViewDelegate>
@property(nonatomic, strong) FSPTimePickerView *pickview;
@end

@implementation FSPTimePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)choosePick:(id)sender {
    [self.view addSubview:self.pickview];
    _pickview.frame = self.view.bounds;

}
- (FSPTimePickerView*)pickview {
    if (!_pickview) {
        _pickview = [[FSPTimePickerView alloc] init];
        _pickview.delegate = self;
    }
    return _pickview;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}


#pragma mark -- SEMITimePickerView delegate
- (void)timePickerViewCancelOrAffirmBtnTargetMethod:(FSPToolTipButtonChooseType)BtnChooseType timeString:(NSString *)timeStr {
    switch (BtnChooseType) {
            case FSPChooseCancelBtn:
        {
            
        }
            break;
            case FSPChooseConfirmButton: //
        {
            
            [self showEmptyViewWithText:timeStr detailText:nil buttonTitle:nil buttonAction:nil];

        }
            break;
            
        default:
            break;
    }
    
    [self.pickview removeFromSuperview];
    _pickview.delegate = nil;
    
}


@end
