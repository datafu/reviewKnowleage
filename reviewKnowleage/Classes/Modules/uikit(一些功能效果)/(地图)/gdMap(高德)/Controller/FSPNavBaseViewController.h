//
//  FSPNavBaseViewController.h
//  reviewKnowleage
//
//  Created by fushp on 2018/12/12.
//  Copyright © 2018年 fushp. All rights reserved.
//
/*
   该基类主要是针对地图基类 封装基础的地图功能 插点 划线 等等
   mapview frame  可自己设置 因为可能地图只是展示一小部分而已
 
 //单次定位回调
 [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
 

 */


#import "BaseCommonViewController.h"


NS_ASSUME_NONNULL_BEGIN

@class POIAnnotation;
@class AMapDistanceResult;
typedef  void (^NearBySearchCompleted)(NSArray<POIAnnotation *> * __nullable response,NSError * __nullable error) ;
typedef void (^DistanceCompleted)(AMapDistanceResult * __nullable response,NSError * __nullable error);
typedef void (^ReGeocodComBlock)(NSDictionary * __nullable response,NSError *__nullable error);
@interface FSPNavBaseViewController : BaseCommonViewController

/*是否进入地图就显示定位小蓝点*/
@property(nonatomic,assign)bool isShowUser;

/* 人 位置 */
@property(nonatomic,assign) CLLocationCoordinate2D  mylatlon;

/* 所有标注点集合 重新set方法 */
@property(nonatomic,strong)NSArray<POIAnnotation *> * nearByArr;


/*加载地图 需要的时候再加载*/
- (void)initMapView;
/* 地图放大 */
- (void)zoonUpMethed;

/* 地图缩小 */
- (void)zoonDownnMethed;

/* 路况 */
- (void)ShowTrafficOnOff;

/**
 *  获取关键字的周边信息
 *@param key 关键字 如:加油站
 *@param completed 周边信息完成后回调
 */
- (void)searchNearByWithKey:(NSString *)key  completed:(NearBySearchCompleted ) completed;


/**
  获取目的地点到 手机位置 的距离
 
 @param destinationCoordinate 目的地
 @param completed 结果回调
 
 */
- (void)getDistance:(CLLocationCoordinate2D)destinationCoordinate completed:(DistanceCompleted )completed;

/**
 根据经纬度逆地址编码

 @param destinationCoordinate 经纬度
 @param completed 结果回调
 */
- (void)searchReGeocodeWithCoordinateWithBlock:(CLLocationCoordinate2D)destinationCoordinate completedWith:(ReGeocodComBlock)completed;




/**
 传入路线规划关联点 将获取的点直接画先展示
 
 @param routeArr 关联点
 
 */
- (void)setRouteArr:(NSArray *)routeArr ;


@end

NS_ASSUME_NONNULL_END
