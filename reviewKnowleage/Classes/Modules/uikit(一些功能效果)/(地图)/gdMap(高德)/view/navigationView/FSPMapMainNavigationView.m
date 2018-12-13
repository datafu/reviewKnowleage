//
//  FSPMapMainNavigationView.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/13.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPMapMainNavigationView.h"

@implementation FSPMapMainNavigationView


- (instancetype)init {
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
    }
    return self;
}
@end
