//
//  FSPPickerView.h
//  reviewKnowleage
//
//  Created by fushp on 2018/11/30.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol FSPPickerViewDelegate <NSObject>
@required

/** picker当前选中的item的值触发改代理方法*/
- (void)pickerView:(UIPickerView *)pickerView selectedRowContent:(NSString *)contentStr;

@end


@interface FSPPickerView : UIPickerView

/** 数据集合 */
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak, nullable) id<FSPPickerViewDelegate> pickerViewDelegate;

@property (nonatomic, copy) NSString *selctedNumStr;

@end

NS_ASSUME_NONNULL_END
