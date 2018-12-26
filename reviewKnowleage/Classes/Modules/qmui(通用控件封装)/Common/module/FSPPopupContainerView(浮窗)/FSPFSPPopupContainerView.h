//
//  FSPFSPPopupContainerView.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/21.
//  Copyright © 2018年 fushp. All rights reserved.
//  自定义浮窗



#import "QMUIPopupContainerView.h"

NS_ASSUME_NONNULL_BEGIN

/*
 自定义视图 添加两个按钮
 
 */

@interface CustomeViewWithTwoBtn : UIView

@property(nonatomic, strong) QMUIButton * collectBtn ;
@property(nonatomic, strong) QMUIButton * downLoadBtn ;
@end

@interface FSPFSPPopupContainerView : QMUIPopupContainerView

@property(nonatomic, strong) CustomeViewWithTwoBtn *popCustomview;

@end





NS_ASSUME_NONNULL_END
