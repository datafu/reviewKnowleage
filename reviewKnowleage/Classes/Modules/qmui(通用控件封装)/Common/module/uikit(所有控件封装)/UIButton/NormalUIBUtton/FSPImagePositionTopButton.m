//
//  FSPImagePositionTopButton.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPImagePositionTopButton.h"

@implementation FSPImagePositionTopButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imagePosition =  QMUIButtonImagePositionTop;

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.imagePosition =  QMUIButtonImagePositionTop;
    }
    return self;
}


@end
