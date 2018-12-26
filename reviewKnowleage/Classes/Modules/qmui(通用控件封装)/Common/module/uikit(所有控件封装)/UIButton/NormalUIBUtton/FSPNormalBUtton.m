//
//  FSPBaseButton.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPNormalBUtton.h"

@implementation FSPNormalBUtton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 4;
        self.titleLabel.font = [QDThemeManager sharedInstance].currentTheme.themeTintFont;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
       self.layer.cornerRadius = 4;
    }
    return self;
}

@end
