//
//  FSPTimePickerView.m
//  reviewKnowleage
//
//  Created by fushp on 2018/11/30.
//  Copyright © 2018年 fushp. All rights reserved.
//  时间管理器



#import "FSPTimePickerView.h"
#import "FSPPickerView.h"
#import "FSPTimeDataTools.h"
@interface FSPTimePickerView()<FSPPickerViewDelegate>
/*标题*/
@property (weak, nonatomic) IBOutlet UILabel *pickTitleNameLab;

/*有效时间*/
@property (weak, nonatomic) IBOutlet UILabel *validLabel;

/*错误提醒*/
@property (weak, nonatomic) IBOutlet UILabel *validTimeWarningLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

/*年*/
@property (weak, nonatomic) IBOutlet FSPPickerView *yearPickerView;

/*月*/
@property (weak, nonatomic) IBOutlet FSPPickerView *monthPickerView;

/*日*/
@property (weak, nonatomic) IBOutlet FSPPickerView *dayPickerView;

/*时*/
@property (weak, nonatomic) IBOutlet FSPPickerView *hourPickerView;

/*分*/
@property (weak, nonatomic) IBOutlet FSPPickerView *minPickerView;


// pickerView dataSource
@property (nonatomic, strong) NSMutableArray *yearArrayM;
@property (nonatomic, strong) NSMutableArray *monthArrayM;
@property (nonatomic, strong) NSMutableArray *dayArrayM;
@property (nonatomic, strong) NSMutableArray *hourArrayM;
@property (nonatomic, strong) NSMutableArray *minuteArrayM;


/** 当前系统时间 有5个数据 index从0到4 分别是 年 月 日 时 分 五个(NSNumber)元素 */
@property (nonatomic, strong) NSArray *currentTimeArray;


// 用户选中的数据
/** 年 */
@property (nonatomic, copy) NSString *yearStr;
/** 月 */
@property (nonatomic, copy) NSString *monthStr;
/** 日 */
@property (nonatomic, copy) NSString *dayStr;
/** 时 */
@property (nonatomic, copy) NSString *hourStr;
/** 分 */
@property (nonatomic, copy) NSString *minuteStr;


@end

@implementation FSPTimePickerView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self initializeVariable];
        
    }
    return  self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeVariable];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
//        [self initializeVariable];
        
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
    }
    return self;
}


#pragma mark -- SEMIPickerView delegate
- (void)pickerView:(FSPPickerView *)pickerView selectedRowContent:(NSString *)contentStr {
    if (self.yearPickerView == pickerView) {
        self.yearStr = contentStr;
    } else if (self.monthPickerView == pickerView) {
        self.monthStr = contentStr;
    } else if (self.dayPickerView == pickerView) {
        self.dayStr = contentStr;
    } else if (self.hourPickerView == pickerView) {
        self.hourStr = contentStr;
    } else if (self.minPickerView == pickerView) {
        self.minuteStr = contentStr;
    }
    
    [self calculateMonthArrayContentItemsAccordingToCurrentSelectedYear:self.yearStr]; // 重新计算 年 数组 元素 (这个有必要存在 当每年的元旦前一秒的选择 需要重置计算当前年份)
    
    if ([self.yearStr integerValue] > [self.yearArrayM.firstObject integerValue]) {
        // 重新计算 所有数组的元素
        self.monthPickerView.dataArray = self.monthArrayM;
        [self calculateDayArrayContentItemsAccordingToCurrentSelectedMonth:self.monthStr];
        self.dayPickerView.dataArray = self.dayArrayM;
        [self calculateHourArrayContentItemsAccordingToCurrentSelectedDay:self.dayStr];
        self.hourPickerView.dataArray = self.hourArrayM;
        [self calculateMinuteArrayContentItemsAccordingToCurrentSelectedHour:self.hourStr];
        self.minPickerView.dataArray = self.minuteArrayM;
        
        // 未来时间 所有的时间都不需要做回滚 或者滚动
        self.monthPickerView.selctedNumStr = self.monthStr;
        self.dayPickerView.selctedNumStr = self.dayStr;
        self.hourPickerView.selctedNumStr = self.hourStr;
        self.minPickerView.selctedNumStr = self.minuteStr;
    }else if ([self.yearStr integerValue] == [self.yearArrayM.firstObject integerValue]) {
        
        self.monthPickerView.dataArray = self.monthArrayM;
        // 判断是否需要重置月份
        if ([self.monthStr integerValue] < [self.monthArrayM.firstObject integerValue]) {
            self.monthStr = self.monthArrayM.firstObject;
            self.monthPickerView.selctedNumStr = self.monthStr;
        }else {
            self.monthPickerView.selctedNumStr = self.monthStr;
        }
        [self calculateDayArrayContentItemsAccordingToCurrentSelectedMonth:self.monthStr]; // 使用新的月份 重新计算 日 数组 元素
        
        self.dayPickerView.dataArray = self.dayArrayM;
        
        // 判断是否需要重置日份
        if ([self.dayStr integerValue] < [self.dayArrayM.firstObject integerValue]) {
            self.dayStr = self.dayArrayM.firstObject;
            self.dayPickerView.selctedNumStr = self.dayStr;
        }else {
            self.dayPickerView.selctedNumStr = self.dayStr;
        }
        [self calculateHourArrayContentItemsAccordingToCurrentSelectedDay:self.dayStr]; // 使用新的日 重新计算 时 数组 元素
        
        self.hourPickerView.dataArray = self.hourArrayM;
        
        // 判断是否需要重置小时
        if ([self.hourStr integerValue] < [self.hourArrayM.firstObject integerValue]) {
            self.hourStr = self.hourArrayM.firstObject;
            self.hourPickerView.selctedNumStr = self.hourStr;
        }else {
            self.hourPickerView.selctedNumStr = self.hourStr;
        }
        [self calculateMinuteArrayContentItemsAccordingToCurrentSelectedHour:self.hourStr]; // 使用新的小时 重新计算 分 数组元素
        
        self.minPickerView.dataArray = self.minuteArrayM;
        
        // 判断是否需要重置分钟
        if ([self.minuteStr integerValue] < [self.minuteArrayM.firstObject integerValue]) {
            self.minuteStr = self.minuteArrayM.firstObject;
            self.minPickerView.selctedNumStr = self.minuteStr;
        }else {
            self.minPickerView.selctedNumStr = self.minuteStr;
        }
    }
}



- (void)initializeVariable {
    self.yearPickerView.pickerViewDelegate = self;
    self.monthPickerView.pickerViewDelegate = self;
    self.dayPickerView.pickerViewDelegate = self;
    self.hourPickerView.pickerViewDelegate = self;
    self.minPickerView.pickerViewDelegate = self;
    self.cancelBtn.layer.borderWidth = 1.0;
    self.cancelBtn.layer.borderColor = Color_15152D_alpha(0.2).CGColor;
    NSString *timeStr = [FSPTimeDataTools getCurrentDateWithFormatString:@"yyyy-MM-dd-HH-mm" andDelayAfterTime:@"86400"]; // 一天86400秒
    self.currentTimeArray = [timeStr componentsSeparatedByString:@"-"];
    if (self.currentTimeArray.count != 5) {
        self.validTimeWarningLabel.hidden = NO;
        [self performSelector:@selector(warringLabNeedHidden) withObject:nil afterDelay:1.0];
    } else {
        self.yearStr = [NSString stringWithFormat:@"%@",self.currentTimeArray[0]];
        self.monthStr = [NSString stringWithFormat:@"%@",self.currentTimeArray[1]];
        self.dayStr = [NSString stringWithFormat:@"%@",self.currentTimeArray[2]];
        self.hourStr = [NSString stringWithFormat:@"%@",self.currentTimeArray[3]];
        self.minuteStr = [NSString stringWithFormat:@"%@",self.currentTimeArray[4]];
        
        [self calculateYearArrayContentItems];
        [self calculateMonthArrayContentItemsAccordingToCurrentSelectedYear:self.yearStr];
        [self calculateDayArrayContentItemsAccordingToCurrentSelectedMonth:self.monthStr];
        [self calculateHourArrayContentItemsAccordingToCurrentSelectedDay:self.dayStr];
        [self calculateMinuteArrayContentItemsAccordingToCurrentSelectedHour:self.hourStr];
        
        self.yearPickerView.dataArray = self.yearArrayM;
        self.monthPickerView.dataArray = self.monthArrayM;
        self.dayPickerView.dataArray = self.dayArrayM;
        self.hourPickerView.dataArray = self.hourArrayM;
        self.minPickerView.dataArray = self.minuteArrayM;
    }
}



- (void)warringLabNeedHidden {
    self.validTimeWarningLabel.hidden = YES;
}


#pragma mark -- 计算年/月/日/时/分 数组的成员变量内的元素值
// 计算年数组内的元素值
- (void)calculateYearArrayContentItems {
    NSUInteger currentSelYear = [self.yearStr integerValue];
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:YEARS_SPAN];
    for (NSUInteger i = currentSelYear; i < currentSelYear + YEARS_SPAN; i++) {
        [temp addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
    [self.yearArrayM removeAllObjects];
    self.yearArrayM = temp;
}

// 计算月份数组内的元素值
- (void)calculateMonthArrayContentItemsAccordingToCurrentSelectedYear:(NSString *)yearStr {
    int currentSelYear = [self.yearStr intValue];
    int currentSystemMonth = [self.currentTimeArray[1] intValue];
    NSMutableArray *temp;
    if (self.yearArrayM.count == 0) {
        return;
    }
    // 月份元素最多12个, 当前选中的年份为系统当前年份,则需要计算剩余可选择的月份时间
    if (currentSelYear == [self.currentTimeArray[0] integerValue]) {
        int circulationTraverseTime = 12 - currentSystemMonth + 1; // 循环遍历次数
        temp = [NSMutableArray arrayWithCapacity:circulationTraverseTime];
        for (int i = currentSystemMonth; i < 12 + 1; i++) {
            [temp addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }else {
        temp = [NSMutableArray arrayWithCapacity:12];
        for (int i = 1; i < 12 + 1; i++) {
            [temp addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }
    
    [self.monthArrayM removeAllObjects];
    self.monthArrayM  = temp;
}

// 计算日份数组内的元素值
- (void)calculateDayArrayContentItemsAccordingToCurrentSelectedMonth:(NSString *)monthStr {
    int currentSelYear = [self.yearStr intValue];
    int currentSelMonth = [self.monthStr intValue];
    int currentSystemDay = [self.currentTimeArray[2] intValue];
    NSInteger dayCount = [FSPTimeDataTools daysCountOfMonth:currentSelMonth inYear:currentSelYear];
    NSMutableArray *temp;
    if (self.monthArrayM.count == 0 | self.yearArrayM.count == 0) {
        return;
    }
    // 选中的年月为当前系统的年月 则需要计算当前月份剩余的日期数组的元素
    if (currentSelYear == [self.currentTimeArray[0] intValue] && currentSelMonth == [self.currentTimeArray[1] intValue]) {
        temp = [NSMutableArray arrayWithCapacity:dayCount - currentSystemDay + 1];
        for (int i = currentSystemDay; i < dayCount + 1; i++) {
            [temp addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }else {
        temp = [NSMutableArray arrayWithCapacity:dayCount];
        for (int i = 1; i < dayCount + 1; i++) {
            [temp addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }
    
    [self.dayArrayM removeAllObjects];
    self.dayArrayM = temp;
    
}

// 计算小时数组内的元素值
- (void)calculateHourArrayContentItemsAccordingToCurrentSelectedDay:(NSString *)dayStr {
    int currentSelYear = [self.yearStr intValue];
    int currentSelMonth = [self.monthStr intValue];
    int currentSelDay = [self.dayStr intValue];
    int currentSystemHour = [self.currentTimeArray[3] intValue];
    NSMutableArray *temp;
    if (currentSelYear == [self.currentTimeArray[0] intValue] && currentSelMonth == [self.currentTimeArray[1] intValue] && currentSelDay == [self.currentTimeArray[2] intValue]) {
        temp = [NSMutableArray arrayWithCapacity:24 - currentSystemHour + 1];
        for (int i = currentSystemHour; i < 24; i++) {
            [temp addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }else {
        temp = [NSMutableArray arrayWithCapacity:24];
        for (int i = 0; i < 24; i++) {
            [temp addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }
    
    [self.hourArrayM removeAllObjects];
    self.hourArrayM = temp;
}

// 计算分钟数组内的元素值
- (void)calculateMinuteArrayContentItemsAccordingToCurrentSelectedHour:(NSString *)hourStr {
    NSString *timeStr = [FSPTimeDataTools getCurrentDateWithFormatString:@"yyyy-MM-dd-HH-mm" andDelayAfterTime:@"86400"];
    self.currentTimeArray = [timeStr componentsSeparatedByString:@"-"];
    int currentSelYear = [self.yearStr intValue];
    int currentSelMonth = [self.monthStr intValue];
    int currentSelDay = [self.dayStr intValue];
    int currentSelHour = [self.hourStr intValue];
    int currentSystemMinute = [self.currentTimeArray[4] intValue];
    NSMutableArray *temp;
    if (currentSelYear == [self.currentTimeArray[0] intValue] && currentSelMonth == [self.currentTimeArray[1] intValue] && currentSelDay == [self.currentTimeArray[2] intValue] && currentSelHour == [self.currentTimeArray[3] intValue]) {
        temp = [NSMutableArray arrayWithCapacity:60 - currentSystemMinute + 1];
        for (int i = currentSystemMinute; i < 60; i++) {
            [temp addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }else {
        temp = [NSMutableArray arrayWithCapacity:60];
        for (int i = 0; i < 60; i++) {
            [temp addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }
    
    [self.minuteArrayM removeAllObjects];
    self.minuteArrayM = temp;
}

- (IBAction)cancel:(id)sender {
    if ([self.delegate respondsToSelector:@selector(timePickerViewCancelOrAffirmBtnTargetMethod:timeString:)]) {
        [self.delegate timePickerViewCancelOrAffirmBtnTargetMethod:FSPChooseCancelBtn timeString:@""];
    }
}
- (IBAction)submit:(id)sender {
    if ([self.delegate respondsToSelector:@selector(timePickerViewCancelOrAffirmBtnTargetMethod:timeString:)]) {
        [self.delegate timePickerViewCancelOrAffirmBtnTargetMethod:FSPChooseConfirmButton timeString:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",self.yearStr,self.monthStr,self.dayStr,self.hourStr,self.minuteStr]];
    }
}


#pragma mark -- 懒加载
- (NSMutableArray *)yearArrayM {
    if (!_yearArrayM) {
        _yearArrayM = [NSMutableArray array];
    }
    return _yearArrayM;
}

- (NSMutableArray *)monthArrayM {
    if (!_monthArrayM) {
        _monthArrayM = [NSMutableArray array];
    }
    return _monthArrayM;
}

- (NSMutableArray *)dayArrayM {
    if (!_dayArrayM) {
        _dayArrayM = [NSMutableArray array];
    }
    return _dayArrayM;
}

- (NSMutableArray *)hourArrayM {
    if (!_hourArrayM) {
        _hourArrayM = [NSMutableArray array];
    }
    return _hourArrayM;
}

- (NSMutableArray *)minuteArrayM {
    if (!_minuteArrayM) {
        _minuteArrayM =[NSMutableArray array];
    }
    return _minuteArrayM;
}


@end
