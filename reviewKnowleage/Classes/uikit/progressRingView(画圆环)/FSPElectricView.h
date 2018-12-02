//
//  FSPElectricView.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/1.
//  Copyright © 2018年 fushp. All rights reserved.
//  填充内环动画效果


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSPElectricView : UIView
/*剩余量*/
@property (nonatomic,assign)CGFloat electric;

- (void)startAnimationWithAngle:(CGFloat)endAngle;
@end

NS_ASSUME_NONNULL_END
