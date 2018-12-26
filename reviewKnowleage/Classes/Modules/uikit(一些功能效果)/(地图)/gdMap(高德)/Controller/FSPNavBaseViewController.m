//
//  FSPNavBaseViewController.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/12.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPNavBaseViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "POIAnnotation.h"
#import "MANaviRoute.h"
#import "LineDashPolyline.h"
#import "MANaviAnnotation.h"
#import "MANaviPolyline.h"
#import <MJExtension.h>
#import "FSPNearByAnnotationView.h"
#import "SEMIWayPointAnnotation.h"
#import "MapManager.h"


static int const kDefaultLocationTimeout = 10;
static int const kDefaultReGeocodeTimeout = 5;
static int const kZoonRatio = 0.2;
static int const knearByrRadius = 10000;//周边范围
static int const knearByOffser = 10; //周边条数
static int const  klineW  = 4;
static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                    = 20;
@interface FSPNavBaseViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>
@property (nonatomic, strong) MAMapView *mapView;
//单次定位 回调
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@property (nonatomic, strong) AMapLocationManager *locationManager;

// 用户周边搜索回调
@property (nonatomic, copy)NearBySearchCompleted  nearBySearchCompleted ;
/// 距离
@property(nonatomic, copy) DistanceCompleted  distanceCompleted;
///逆地址解析回调
@property(nonatomic, copy) ReGeocodComBlock reGeocodComBlock;

// 关键字搜索
@property (nonatomic, strong) AMapSearchAPI *search;

/// 保存当前选中的标注
@property(nonatomic, strong) FSPNearByAnnotationView *selectedNearByAnnotationView;

/* 起始点经纬度. */
@property (nonatomic,strong) AMapTip *startCoordinate;
/* 终点经纬度. */
@property (nonatomic,strong) AMapTip *destinationCoordinate;

/* 起点标注. */
@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
/* 终点标注. */
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;
/// 路线规划返回的所有点信息
@property (nonatomic,strong) NSMutableArray *wayPoints;
/// 用于显示当前路线方案.
@property (nonatomic) MANaviRoute * naviRoute;
@end

@implementation FSPNavBaseViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat y = self.qmui_navigationBarMaxYInViewCoordinator;
    // mapview Frame 可以自己设置
    _mapView.frame =self.view.bounds;
    _mapView.frame = CGRectSetY(_mapView.frame, y);
    
}

- (void)dealloc
{
    [self cleanUpAction];
    
}



#pragma mark - MAMapViewDelegate

//实现 MAMapViewDelegate，获取用户当前经纬坐标：
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    QMUILogInfo(@"MAMapView",@"%s",__FILE__);
    if (updatingLocation)
    {
        //更新经纬度
        self.mylatlon = userLocation.location.coordinate;
    }
}

//地图覆盖图型 路线
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:(MACircle*)overlay];
        
        circleRenderer.lineWidth   = 1.f;

        circleRenderer.strokeColor = [UIColor qmui_colorWithHexString:@"b3b3b3"];;
        circleRenderer.fillColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        return circleRenderer;
    }
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth  = 8;
        polylineRenderer.lineDashType = kMALineDashTypeSquare;
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = klineW;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
//            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway)
        {
//            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else
        {
//            polylineRenderer.strokeColor = lineColor;
        }
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:(MAMultiPolyline*)overlay];
        
        polylineRenderer.lineWidth = klineW;
//        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        
        return polylineRenderer;
    }
    
    return nil;
}


/// 根据anntation生成对应的View
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAUserLocation class]]){
        return nil;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
        
        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.image = nil;
        if ([annotation isKindOfClass:[SEMIWayPointAnnotation class]]){
            poiAnnotationView.image = [UIImage imageNamed:@"nav_way_ico"];
        }else{
            /* 起点. */
            if ([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerStartTitle])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"nav_rise_ico"];
            }
            /* 终点. */
            else if([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerDestinationTitle])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"nav_end_ico"];
            }
        }
    }
    //周边
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        //static NSString *poiIdentifier = @"poiIdentifier";
        FSPNearByAnnotationView *poiAnnotationView = (FSPNearByAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:nil];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[FSPNearByAnnotationView alloc] initWithAnnotation:annotation
                                                                     reuseIdentifier:nil];
        }
        POIAnnotation * poiAnnotation =(POIAnnotation *)annotation;
        poiAnnotationView.canShowCallout = NO;
        poiAnnotationView.image = nil;
        if(poiAnnotation.isSelected){
            self.selectedNearByAnnotationView = poiAnnotationView;
            if([poiAnnotation.showType isEqualToString:@"0"]){
                poiAnnotationView.image = [UIImage imageNamed:@"nav_bubble_big_ico"];
            }else{
                poiAnnotationView.image = [UIImage imageNamed:@"nav_bubble_small_ico"];
            }

        }
        return poiAnnotationView;

    }
    return nil;
}


- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([view isKindOfClass:[FSPNearByAnnotationView class]]) {
        
        if(self.selectedNearByAnnotationView){
            POIAnnotation * poiAnnotation=(POIAnnotation *)self.selectedNearByAnnotationView.annotation;
            
            poiAnnotation.isSelected = false;
            self.selectedNearByAnnotationView.image = [UIImage imageNamed:@"nav_bubble_small_ico"];
        }
        POIAnnotation * annotation =(POIAnnotation *)view.annotation;
        annotation.isSelected =true;
        self.selectedNearByAnnotationView =(FSPNearByAnnotationView *)view;
        [_mapView setCenterCoordinate:annotation.coordinate animated:YES];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"NEARBY_NOTICE" object:view.annotation];
    }
    
}


#pragma mark - AMapSearchDelegate

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        if( self.nearBySearchCompleted){
            self.nearBySearchCompleted(nil, nil);
        }
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        POIAnnotation *annotation  = [[POIAnnotation alloc] initWithPOI:obj];
        if(idx==0){
            annotation.isSelected=YES;
        }
        annotation.showType=@"0";
        [poiAnnotations addObject:annotation];
        
    }];
    
    if( self.nearBySearchCompleted){
        self.nearBySearchCompleted(poiAnnotations, nil);
    }
}

- (void)onDistanceSearchDone:(AMapDistanceSearchRequest *)request response:(AMapDistanceSearchResponse *)response
{
    if (response.results.firstObject) {
        AMapDistanceResult *result = response.results.firstObject;
        if(self.distanceCompleted){
            self.distanceCompleted(result, nil);
        }
        
    }
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
//        self.cityStr=response.regeocode.addressComponent.city;
//        [SEMITipStoreManage saveCityByName:self.cityStr];
        if(self.reGeocodComBlock){
            AMapAddressComponent *addressComponent= response.regeocode.addressComponent;
            if(addressComponent){
                NSDictionary *dic =addressComponent.mj_keyValues;
                self.reGeocodComBlock(dic,nil);
            }else{
                self.reGeocodComBlock(nil,[NSError new]);
            }
            
        }
    }
    
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil)
    {
        return;
    }
    
    
    if (response.count > 0)
    {
      
        [self presentCurrentCourse:response.route];
        
        
    }
}

- (void)presentCurrentCourse:(AMapRoute*)route
{
    MANaviAnnotationType type = MANaviAnnotationTypeDrive;
    self.naviRoute = [MANaviRoute naviRouteForPath:route.paths[0] withNaviType:type showTraffic:NO startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude]];
    [self.naviRoute addToMapView:_mapView];

//    switch (self.routeType) {
//        case SEMIRouteTypeShow:
//            [self.naviRoute addToMapView:self.mapView];
//            break;
//
//        default:
//
//            break;
//    }
    
    
    /* 缩放地图使其适应polylines的展示. */
    [_mapView setVisibleMapRect:[MapManager mapRectForOverlays:self.naviRoute.routePolylines]
                edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
}

#pragma mark - private methods

///需要加载地图的时候 自己调用该方法
- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        self.mapView.zoomLevel = 16.1;
        [self.mapView setDelegate:self];
        [self.view insertSubview:self.mapView atIndex:0];
        //定制 我的位置样式
        MAUserLocationRepresentation *represent = [[MAUserLocationRepresentation alloc] init];
        represent.showsAccuracyRing = NO;
        represent.showsHeadingIndicator = YES;
        represent.fillColor = [UIColor clearColor];
        //            represent.strokeColor = [UIColor lightGrayColor];;
        represent.strokeColor = [UIColor clearColor];;
        represent.lineWidth = 2.f;
        represent.image = [UIImage imageNamed:@"nav_i_position_ico"];
        [self.mapView updateUserLocationRepresentation:represent];
#warning  打开
        self.isShowUser = YES;
        if (self.isShowUser) {
            self.mapView.showsUserLocation = YES;
            self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        }
    }
}


- (void)cleanUpAction
{
    //停止定位
    [_locationManager stopUpdatingLocation];
    
    [_locationManager setDelegate:nil];
    
    [_mapView removeAnnotations:_mapView.annotations];
    _completionBlock = nil;
    _nearBySearchCompleted = nil;
    
}

//进行单次带逆地理定位请求
- (void)reGeocodeAction
{
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

/// 逆地址解析
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}



//进行单次定位请求
- (void)locAction
{
    
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:self.completionBlock];
}

///  地图放大
- (void)zoonUpMethed {
    [_mapView setZoomLevel:(_mapView.zoomLevel + kZoonRatio)];
}

/// 地图缩小
- (void)zoonDownnMethed{
    [_mapView setZoomLevel:(_mapView.zoomLevel - kZoonRatio)];

}

/// 路况打开或许关闭
- (void)ShowTrafficOnOff {
    [_mapView setShowTraffic:!_mapView.showTraffic];
}
/// 获取关键字的周边信息
- (void)searchNearByWithKey:(NSString *)key  completed:(NearBySearchCompleted) completed
{
    self.nearBySearchCompleted = completed;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:self.mylatlon.latitude longitude:self.mylatlon.longitude];
    request.radius =knearByrRadius;
    request.keywords            = key;
    request.offset =knearByOffser;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];

}


/// 获取目的地点到 手机位置 的距离
- (void)getDistance:(CLLocationCoordinate2D)destinationCoordinate completed:(DistanceCompleted )completed {
    self.distanceCompleted = completed;
    self.nearBySearchCompleted=nil;
    AMapDistanceSearchRequest *request = [[AMapDistanceSearchRequest alloc] init];
    request.type = 1;
    NSMutableArray *origins =[NSMutableArray array];
    [origins addObject:[AMapGeoPoint locationWithLatitude:self.mylatlon.latitude longitude:self.mylatlon.longitude]];
    request.origins = origins;
    request.destination = [AMapGeoPoint locationWithLatitude:destinationCoordinate.latitude longitude:destinationCoordinate.longitude];
    [self.search AMapDistanceSearch:request];
}


/// 根据经纬度逆地址编码
- (void)searchReGeocodeWithCoordinateWithBlock:(CLLocationCoordinate2D)destinationCoordinate completedWith:(ReGeocodComBlock)completed {
    self.reGeocodComBlock = completed;
    self.distanceCompleted=nil;
    self.nearBySearchCompleted=nil;
    [self searchReGeocodeWithCoordinate:destinationCoordinate];
}


/// 传入路线规划关联点 将获取的点直接画先展示
- (void)setRouteArr:(NSArray *)routeArr  {
    [self searchRoutePlanningDrive:routeArr];
}

- (void)searchRoutePlanningDrive:(NSArray*)routeArr{
    if(routeArr && routeArr.count>=2){
        for (int i=0; i<routeArr.count; i++) {
            AMapTip *tip =routeArr[i];
            if(i==0){
                self.startCoordinate=tip;
            }else if (i==routeArr.count-1){
                self.destinationCoordinate =tip;
            }else{
                [self.wayPoints  addObject:tip];
            }
        }
        AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
        navi.strategy=0;
        navi.requireExtension = YES;
        NSMutableArray *waypointsArr =[NSMutableArray array];//途经点
        navi.origin= self.startCoordinate.location;
      
        navi.destination=self.destinationCoordinate.location;
        
        if(self.wayPoints.count>0){
            for (AMapTip *tip in self.wayPoints) {
                AMapGeoPoint *point =[AMapGeoPoint locationWithLatitude:tip.location.latitude longitude:tip.location.longitude];
                [waypointsArr addObject:point];
            }
            navi.waypoints = waypointsArr;
        }
        
        
        //给地图添加起始，途经点
        [self addDefaultAnnotations];
        //开始查找 成功后调用代理方法(void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
        [self.search AMapDrivingRouteSearch:navi];
        
        
    }
    
}
///  添加起始点标注
- (void)addDefaultAnnotations
{
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = CLLocationCoordinate2DMake(self.startCoordinate.location.latitude, self.startCoordinate.location.longitude) ;
    startAnnotation.title      = (NSString*)RoutePlanningViewControllerStartTitle;
    startAnnotation.subtitle   = self.startCoordinate.district;
    self.startAnnotation = startAnnotation;
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = CLLocationCoordinate2DMake(self.destinationCoordinate.location.latitude, self.destinationCoordinate.location.longitude);
    destinationAnnotation.title      = (NSString*)RoutePlanningViewControllerDestinationTitle;
    destinationAnnotation.subtitle   = self.destinationCoordinate.district;
    self.destinationAnnotation = destinationAnnotation;
    
    [_mapView addAnnotation:startAnnotation];
    [_mapView addAnnotation:destinationAnnotation];
    if(self.wayPoints.count>0){
        for (AMapTip *tip in self.wayPoints) {
            CLLocationCoordinate2D wayCoordinate = CLLocationCoordinate2DMake(tip.location.latitude,tip.location.longitude);
            SEMIWayPointAnnotation *wayAnnotation = [[SEMIWayPointAnnotation alloc] init];
            wayAnnotation.coordinate = wayCoordinate;
            wayAnnotation.title      =tip.name;
            wayAnnotation.subtitle   = tip.district;
            [_mapView addAnnotation:wayAnnotation];
        }
    }
}


#pragma mark - setting and getting
- (AMapLocationManager*)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        
        [_locationManager setDelegate:self];
        
        //设置期望定位精度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        
        //设置不允许系统暂停定位
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        
        //设置允许在后台定位
        [_locationManager setAllowsBackgroundLocationUpdates:YES];
        
        //设置定位超时时间
        [_locationManager setLocationTimeout:kDefaultLocationTimeout];
        
        //设置逆地理超时时间
        [_locationManager setReGeocodeTimeout:kDefaultReGeocodeTimeout];
        
        //设置开启虚拟定位风险监测，可以根据需要开启
        [self.locationManager setDetectRiskOfFakeLocation:NO];
    }
    return _locationManager;
}

/// 当次请求定位信息的回调函数
- (AMapLocatingCompletionBlock)completionBlock {
    if (!_completionBlock) {
        __weak __typeof(self)weakSelf = self;
        _completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
        {
            if (error != nil && error.code == AMapLocationErrorLocateFailed)
            {
                //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                //添加一个冒泡提示即可
                NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.userInfo);
                [QMUITips showInfo:@"定位失败,请查看手机设置中是否开启定位权限" inView:weakSelf.view hideAfterDelay:1.2];
                return;
            }
            else if (error != nil
                     && (error.code == AMapLocationErrorReGeocodeFailed
                         || error.code == AMapLocationErrorTimeOut
                         || error.code == AMapLocationErrorCannotFindHost
                         || error.code == AMapLocationErrorBadURL
                         || error.code == AMapLocationErrorNotConnectedToInternet
                         || error.code == AMapLocationErrorCannotConnectToHost))
            {
                //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
//                [QMUITips showInfo:@"定位失败,请查看手机设置中是否开启定位权限" inView:weakSelf.view hideAfterDelay:1.2];
                NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.userInfo);
            }
            else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
            {
                //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
                NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.userInfo);
                
                //存在虚拟定位的风险的定位结果
                __unused CLLocation *riskyLocateResult = [error.userInfo objectForKey:@"AMapLocationRiskyLocateResult"];
                //存在外接的辅助定位设备
                __unused NSDictionary *externalAccressory = [error.userInfo objectForKey:@"AMapLocationAccessoryInfo"];
                
                return;
            }
            else
            {
                //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                weakSelf.mylatlon = location.coordinate;
            }
            //根据定位信息，添加annotation
//            MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
//            [annotation setCoordinate:location.coordinate];
//
            //有无逆地理信息，annotationView的标题显示的字段不一样
            if (regeocode)
            {
                
//                [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
//                [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
            }
            else
            {
//                [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
//                [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
            }
            
            //        SingleLocationViewController *strongSelf = weakSelf;
            //        [strongSelf addAnnotationToMapView:annotation];
        };
    }
    return _completionBlock;
}

/// 结果以annotation的形式加载到地图上
- (void)setNearByArr:(NSArray<POIAnnotation *> *)nearByArr{
    _nearByArr = nearByArr;
    [self.view setNeedsLayout];
    /* 将结果以annotation的形式加载到地图上. */
    [_mapView addAnnotations:nearByArr];
    POIAnnotation *firstAnnotation=nearByArr.firstObject;
    [_mapView showAnnotations:nearByArr animated:NO];
    [_mapView setCenterCoordinate:[firstAnnotation coordinate]];
}

- (NSMutableArray*)wayPoints {
    if (!_wayPoints) {
        _wayPoints = [NSMutableArray array];
    }
    return _wayPoints;
}

@end
