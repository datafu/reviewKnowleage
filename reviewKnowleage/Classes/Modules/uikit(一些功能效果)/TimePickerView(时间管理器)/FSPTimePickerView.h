//
//  FSPTimePickerView.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/30.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    FSPChooseCancelBtn,
    FSPChooseConfirmButton,
} FSPToolTipButtonChooseType;


@protocol FSPTimePickerViewDelegate <NSObject>

@required
- (void)timePickerViewCancelOrAffirmBtnTargetMethod:(FSPToolTipButtonChooseType)BtnChooseType timeString:(NSString *)timeStr;

@end

// 时间跨度年份
#define YEARS_SPAN 2

@interface FSPTimePickerView : UIView

/** 时间选择期 代理方法 */
@property (nonatomic, weak, nullable) id<FSPTimePickerViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
