//
//  FSPFillButton.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPFillButton.h"

@implementation FSPFillButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.fillColor =  [QDThemeManager sharedInstance].currentTheme.themeTintColor;
        self.titleLabel.font = [QDThemeManager sharedInstance].currentTheme.themeTintFont;

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
       self.fillColor =  [QDThemeManager sharedInstance].currentTheme.themeTintColor;
        self.titleLabel.font = [QDThemeManager sharedInstance].currentTheme.themeTintFont;

    }
    return self;
}

@end
