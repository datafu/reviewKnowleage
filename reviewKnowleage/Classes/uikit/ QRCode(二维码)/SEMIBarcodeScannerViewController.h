//
//  SEMIBarcodeScannerViewController.h
//  SEMI-IV
//
//  Created by fushp on 2018/11/28.
//  Copyright © 2018年 soueast-motor. All rights reserved.
//   直接push 这个控制器即可

#import "BaseCommonViewController.h"
#import "LBXScanView.h"
#import "ZXingWrapper.h" //ZXing扫码封装
#import "LBXScanTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 扫码结果delegate,也可通过继承本控制器，override方法scanResultWithArray即可
 */
@protocol SEMIScanViewControllerDelegate <NSObject>
@optional
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array;
@end


@interface SEMIBarcodeScannerViewController : BaseCommonViewController

#ifdef LBXScan_Define_ZXing
/**
 ZXing扫码对象
 */
@property (nonatomic, strong) ZXingWrapper *zxingObj;
#endif

@property (nonatomic,strong) LBXScanView* qRScanView;
//扫码结果委托，另外一种方案是通过继承本控制器，override方法scanResultWithArray即可
@property (nonatomic, weak) id<SEMIScanViewControllerDelegate> delegate;

/**
 相机启动提示,如 相机启动中...
 */
@property (nonatomic, copy) NSString *cameraInvokeMsg;

/**
 *  界面效果参数
 */
#ifdef LBXScan_Define_UI
@property (nonatomic, strong) LBXScanViewStyle *style;
#endif

@end

NS_ASSUME_NONNULL_END
