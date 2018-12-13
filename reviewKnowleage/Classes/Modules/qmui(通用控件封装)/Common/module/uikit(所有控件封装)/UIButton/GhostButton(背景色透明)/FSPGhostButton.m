//
//  FSPGhostButton.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPGhostButton.h"

@implementation FSPGhostButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.ghostColor =  [QDThemeManager sharedInstance].currentTheme.themeTintColor;
        self.titleLabel.font = [QDThemeManager sharedInstance].currentTheme.themeTintFont;

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.ghostColor =  [QDThemeManager sharedInstance].currentTheme.themeTintColor;
        self.titleLabel.font = [QDThemeManager sharedInstance].currentTheme.themeTintFont;

    }
    return self;
}

@end
