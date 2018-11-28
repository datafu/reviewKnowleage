//
//  QDCommonUI.m
//  reviewKnowleage
//
//  Created by fushp on 2018/10/16.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "QDCommonUI.h"
#import "QDUIHelper.h"

NSString *const QDSelectedThemeClassName = @"selectedThemeClassName";

const CGFloat QDButtonSpacingHeight = 72;

@implementation QDCommonUI


+ (void)renderGlobalAppearances {
    [QDUIHelper customMoreOperationAppearance];
    [QDUIHelper customAlertControllerAppearance];
    [QDUIHelper customDialogViewControllerAppearance];
    [QDUIHelper customImagePickerAppearance];
    [QDUIHelper customEmotionViewAppearance];
}
@end


@implementation QDCommonUI (ThemeColor)

static NSArray<UIColor *> *themeColors = nil;
+ (UIColor *)randomThemeColor {
    if (!themeColors) {
        themeColors = @[UIColorTheme1,
                        UIColorTheme2,
                        UIColorTheme3,
                        UIColorTheme4,
                        UIColorTheme5,
                        UIColorTheme6,
                        UIColorTheme7,
                        UIColorTheme8,
                        UIColorTheme9];
    }
    return themeColors[arc4random() % 9];
}

@end


