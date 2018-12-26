//
//  FSPFSPPopupContainerView.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/21.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPFSPPopupContainerView.h"


@interface CustomeViewWithTwoBtn()

@end

@implementation CustomeViewWithTwoBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInit ];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectBtn.frame = CGRectMake(0, 0, 65, 65);
    self.downLoadBtn.frame = CGRectMake(64, 0, 65, 65);
}

- (void) didInit {
    self.collectBtn = [[QMUIButton alloc] init];
    self.collectBtn.imagePosition =  QMUIButtonImagePositionTop;
    self.collectBtn.spacingBetweenImageAndTitle = 5;
    [self.collectBtn setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
//    [self.collectBtn setTitle:NSLocalizedString(@"QMUIButton_Image_Position_Button_Title_1", @"Text below image") forState:UIControlStateNormal];
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];

    self.collectBtn.titleLabel.font = UIFontMake(14);
    
    self.downLoadBtn = [[QMUIButton alloc] init];
    self.downLoadBtn.imagePosition =  QMUIButtonImagePositionTop;
    self.downLoadBtn.spacingBetweenImageAndTitle = 5;
    [self.downLoadBtn setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
    [self.downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
    self.downLoadBtn.titleLabel.font = UIFontMake(14);
    [self addSubview:self.collectBtn];
    [self addSubview:self.downLoadBtn];
    
}
@end



@interface FSPFSPPopupContainerView()
//@property(nonatomic, strong) CustomeViewWithTwoBtn *customview;
@property(nonatomic, strong) QMUIButton * collectBtn ;

@end

@implementation FSPFSPPopupContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentEdgeInsets = UIEdgeInsetsZero;
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.popCustomview];
     
//        self.collectBtn = [[QMUIButton alloc] init];
//        self.collectBtn.imagePosition =  QMUIButtonImagePositionTop;
//        self.collectBtn.spacingBetweenImageAndTitle = 5;
//        [self.collectBtn setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
//        //    [self.collectBtn setTitle:NSLocalizedString(@"QMUIButton_Image_Position_Button_Title_1", @"Text below image") forState:UIControlStateNormal];
//        [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
//
//        self.collectBtn.titleLabel.font = UIFontMake(14);
//        [self.collectBtn addTarget:self action:@selector(clickCollect) forControlEvents:UIControlEventTouchUpInside];
//
//        [self.contentView addSubview:self.collectBtn];
    }
    return self;
}

- (CGSize)sizeThatFitsInContentView:(CGSize)size {
    return CGSizeMake(130 , 65);
}



- (void)layoutSubviews {
    [super layoutSubviews];
    // 所有布局都参照 contentView
    self.collectBtn.frame = CGRectMake(0, 0, 65, 65);
    //需要设置frame 不然不能响应 事件
    self.popCustomview.frame = self.contentView.bounds;

}

- (CustomeViewWithTwoBtn*)popCustomview {
    if (!_popCustomview) {
        _popCustomview = [[CustomeViewWithTwoBtn alloc] init];
        _popCustomview.userInteractionEnabled = YES;
       [_popCustomview.collectBtn addTarget:self action:@selector(clickCollect) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _popCustomview;
}
- (void)clickCollect {
    QMUILog(@"clickCollect",@"");
}
@end



