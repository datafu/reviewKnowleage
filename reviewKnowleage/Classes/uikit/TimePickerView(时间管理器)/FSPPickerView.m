//
//  FSPPickerView.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/30.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPPickerView.h"


@interface FSPPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>


@end


@implementation FSPPickerView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return  self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}


// 选中指定数据居中
- (void)setSelctedNumStr:(NSString *)selctedNumStr {
    _selctedNumStr = selctedNumStr;
    static NSInteger rowIndex = 0;
    
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([selctedNumStr isEqualToString:obj]) {
            rowIndex = idx;
            *stop = YES;
        }
    }];
    // 滚动到指定位置
    [self selectRow:rowIndex inComponent:0 animated:YES];
}



- (void)setDataArray:(NSArray *)dataArray {
    if (_dataArray.count == dataArray.count) {
        return;
    }
    _dataArray = dataArray.copy;
    [self reloadAllComponents];
}



#pragma mark -- dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

#pragma mark -- delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *text = (UILabel *)view;
    if (!text){
        text = [[UILabel alloc] init];
        text.textAlignment = NSTextAlignmentCenter;
        text.font = [UIFont boldSystemFontOfSize:18];
    }
    text.text = [self.dataArray objectAtIndex:row];
    [self.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
    [self.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
    
    return text;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    UILabel *lab = (UILabel *)[pickerView viewForRow:row forComponent:component];
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textColor = [UIColor blackColor];
    if ([self.pickerViewDelegate respondsToSelector:@selector(pickerView:selectedRowContent:)]) {
        [self.pickerViewDelegate pickerView:self selectedRowContent:lab.text];
    }
}


@end
