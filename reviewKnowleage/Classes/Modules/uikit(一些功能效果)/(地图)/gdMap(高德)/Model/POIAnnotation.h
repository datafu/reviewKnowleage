//
//  POIAnnotation.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-16.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapCommonObj.h>

@interface POIAnnotation : NSObject <MAAnnotation>

- (id)initWithPOI:(AMapPOI *)poi;

@property (nonatomic, readonly, strong) AMapPOI *poi;

/*isSelected YES 选中 NO 未选中*/
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) NSString *showType;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,assign) NSInteger duration;
/*!
 @brief 获取annotation标题
 @return 返回annotation的标题信息
 */
- (NSString *)title;

/*!
 @brief 获取annotation副标题
 @return 返回annotation的副标题信息
 */
- (NSString *)subtitle;

@end
