//
//  QDCommonUI.h
//  reviewKnowleage
//
//  Created by fushp on 2018/10/16.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import <Foundation/Foundation.h>


#define UIColorGray1 UIColorMake(53, 60, 70)
#define UIColorGray2 UIColorMake(73, 80, 90)
#define UIColorGray3 UIColorMake(93, 100, 110)
#define UIColorGray4 UIColorMake(113, 120, 130)
#define UIColorGray5 UIColorMake(133, 140, 150)
#define UIColorGray6 UIColorMake(153, 160, 170)
#define UIColorGray7 UIColorMake(173, 180, 190)
#define UIColorGray8 UIColorMake(196, 200, 208)
#define UIColorGray9 UIColorMake(216, 220, 228)

#define Color_15152D_alpha(a) [UIColor colorWithRed:21.0 / 255.0 green:21.0 / 255.0 blue:45.0/255.0 alpha:(a)]

#define UIColorTheme1 UIColorMake(239, 83, 98) // Grapefruit
#define UIColorTheme2 UIColorMake(254, 109, 75) // Bittersweet
#define UIColorTheme3 UIColorMake(255, 207, 71) // Sunflower
#define UIColorTheme4 UIColorMake(159, 214, 97) // Grass
#define UIColorTheme5 UIColorMake(63, 208, 173) // Mint
#define UIColorTheme6 UIColorMake(49, 189, 243) // Aqua
#define UIColorTheme7 UIColorMake(90, 154, 239) // Blue Jeans
#define UIColorTheme8 UIColorMake(172, 143, 239) // Lavender
#define UIColorTheme9 UIColorMake(238, 133, 193) // Pink Rose


extern NSString * const QDSelectedThemeClassName;
/// QMUIButton 系列 Demo 里的一行高度
extern const CGFloat QDButtonSpacingHeight;

@interface QDCommonUI : NSObject

/**
 更新全局 UI 控件的 appearance
 */
+ (void)renderGlobalAppearances;

@end

@interface QDCommonUI (ThemeColor)

+ (UIColor *)randomThemeColor;
@end


