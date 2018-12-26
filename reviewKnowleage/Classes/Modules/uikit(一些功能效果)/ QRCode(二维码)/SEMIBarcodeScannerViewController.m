//
//  SEMIBarcodeScannerViewController.m
//  SEMI-IV
//
//  Created by fushp on 2018/11/28.
//  Copyright © 2018年 soueast-motor. All rights reserved.
//

#import "SEMIBarcodeScannerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LBXPermission.h"
#import "LBXPermissionSetting.h"
@interface SEMIBarcodeScannerViewController ()<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIImageView *scannerview;
@end

@implementation SEMIBarcodeScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scannerview.hidden = YES;
    self.style = [self setColor];
    self.cameraInvokeMsg = @"相机启动中";
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self drawScanView];
    __weak __typeof(self)weakSelf = self;
    [self requestCameraPemissionWithResult:^(BOOL granted) {
        
        if (granted) {
            
            //不延时，可能会导致界面黑屏并卡住一会
            [self performSelector:@selector(startScan) withObject:nil afterDelay:0.3];
            
        }else{
            
            [weakSelf.qRScanView stopDeviceReadying];
            
        }
    }];
    
}

#pragma mark -自定义4个角及矩形框颜色
- (LBXScanViewStyle*)setColor
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    style.centerUpOffset = 74 + 64 + 20;
    //扫码框周围4个角的类型设置为在框的上面
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    //扫码框周围4个角绘制线宽度
    style.photoframeLineW = 1;
    style.xScanRetangleOffset = 15;
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 17;
    style.photoframeAngleH = 17;

    //显示矩形框
    style.isNeedShowRetangle = NO;
    style.whRatio = 1.66;
    //动画类型：网格形式，模仿支付宝
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];;
    //码框周围4个角的颜色
    //    style.colorAngle = [UIColor colorWithRed:65./255. green:174./255. blue:57./255. alpha:1.0];
    style.colorAngle = [UIColor whiteColor];
    
    //矩形框颜色
    //    style.colorRetangleLine = [UIColor colorWithRed:247/255. green:202./255. blue:15./255. alpha:1.0];
    style.colorRetangleLine = [UIColor clearColor];
    
    //非矩形框区域颜色
    //    style.notRecoginitonArea = [UIColor colorWithRed:247./255. green:202./255 blue:15./255 alpha:0.2];
    
    return style;
}

//启动设备
- (void)startScan
{
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-300)];
    videoView.backgroundColor = [UIColor clearColor];
//    [self.view insertSubview:videoView atIndex:0];
    [self.photoView insertSubview:videoView atIndex:0];
    __weak __typeof(self) weakSelf = self;
    if (!_zxingObj) {
        
        __weak __typeof(self) weakSelf = self;
        self.zxingObj = [[ZXingWrapper alloc]initWithPreView:videoView block:^(ZXBarcodeFormat barcodeFormat, NSString *str, UIImage *scanImg) {
            
            LBXScanResult *result = [[LBXScanResult alloc]init];
            result.strScanned = str;
            result.imgScanned = scanImg;
            result.strBarCodeType = [weakSelf convertZXBarcodeFormat:barcodeFormat];
            
            [weakSelf scanResultWithArray:@[result]];
            
        }];
            //设置只识别框内区域
//            CGRect cropRect = [LBXScanView getZXingScanRectWithPreView:videoView style:_style];
        
//            [_zxingObj setScanRect:cropRect];
    }
    [_zxingObj start];
    
#ifdef LBXScan_Define_UI
    [_qRScanView stopDeviceReadying];
    [_qRScanView startScanAnimation];
#endif
    
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark -扫码结果处理

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
//    BKLog(@"%s%@",__func__,array);
    if (array.count < 1)
    {
//        [SEMIShowHUD showHUDWithWarringText:@"未发现条形码" addView:self.view];
        return;
    }
    LBXScanResult *scanResult = array[0];
    if(scanResult.strScanned.length == 0) {
//        [SEMIShowHUD showHUDWithWarringText:@"未发现条形码" addView:self.view];
        return ;
    }
    if(scanResult.strBarCodeType == AVMetadataObjectTypeQRCode) { //二维码
//        [SEMIShowHUD showHUDWithWarringText:@"未发现条形码" addView:self.view];
        return;
    }
    
    //设置了委托的处理
    if (_delegate) {
        [_delegate scanResultWithArray:array];
    }
    [self.navigationController popViewControllerAnimated:YES];

}


#ifdef LBXScan_Define_ZXing
- (NSString*)convertZXBarcodeFormat:(ZXBarcodeFormat)barCodeFormat
{
    NSString *strAVMetadataObjectType = nil;
    
    switch (barCodeFormat) {
        case kBarcodeFormatQRCode:
            strAVMetadataObjectType = AVMetadataObjectTypeQRCode;
            break;
        case kBarcodeFormatEan13:
            strAVMetadataObjectType = AVMetadataObjectTypeEAN13Code;
            break;
        case kBarcodeFormatEan8:
            strAVMetadataObjectType = AVMetadataObjectTypeEAN8Code;
            break;
        case kBarcodeFormatPDF417:
            strAVMetadataObjectType = AVMetadataObjectTypePDF417Code;
            break;
        case kBarcodeFormatAztec:
            strAVMetadataObjectType = AVMetadataObjectTypeAztecCode;
            break;
        case kBarcodeFormatCode39:
            strAVMetadataObjectType = AVMetadataObjectTypeCode39Code;
            break;
        case kBarcodeFormatCode93:
            strAVMetadataObjectType = AVMetadataObjectTypeCode93Code;
            break;
        case kBarcodeFormatCode128:
            strAVMetadataObjectType = AVMetadataObjectTypeCode128Code;
            break;
        case kBarcodeFormatDataMatrix:
            strAVMetadataObjectType = AVMetadataObjectTypeDataMatrixCode;
            break;
        case kBarcodeFormatITF:
            strAVMetadataObjectType = AVMetadataObjectTypeITF14Code;
            break;
        case kBarcodeFormatRSS14:
            break;
        case kBarcodeFormatRSSExpanded:
            break;
        case kBarcodeFormatUPCA:
            break;
        case kBarcodeFormatUPCE:
            strAVMetadataObjectType = AVMetadataObjectTypeUPCECode;
            break;
        default:
            break;
    }
    
    
    return strAVMetadataObjectType;
}
#endif

- (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion
{
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                completion(YES);
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                completion(NO);
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {
                                             
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 if (granted) {
                                                     completion(true);
                                                 } else {
                                                     completion(false);
                                                 }
                                             });
                                             
                                         }];
            }
                break;
                
        }
    }
    
    
}


//绘制扫描区域
- (void)drawScanView
{

    if (!_qRScanView)
    {
        CGRect rect = self.view.frame;
//        rect.origin = CGPointMake(0, 64);
    
        self.qRScanView = [[LBXScanView alloc]initWithFrame:rect style:_style];
        
//        [self.view addSubview:_qRScanView];
        [self.photoView addSubview:_qRScanView];
    }
    
    if (!_cameraInvokeMsg) {
        
        //        _cameraInvokeMsg = NSLocalizedString(@"wating...", nil);
    }
    
    [_qRScanView startDeviceReadyingWithText:_cameraInvokeMsg];
}

- (IBAction)openLightMethed:(UIButton *)sender {
    sender.selected = !sender.selected;
    [_zxingObj openOrCloseTorch];

}
#pragma mark -选择相册照片
- (IBAction)choosePhotoMethed:(UIButton *)sender {
    __weak __typeof(self) weakSelf = self;
    [LBXPermission authorizeWithType:LBXPermissionType_Photos completion:^(BOOL granted, BOOL firstTime) {
        if (granted) {
            [weakSelf openLocalPhoto:NO];
        }
        else if (!firstTime )
        {
            [LBXPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相册权限，是否前往设置" cancel:@"取消" setting:@"设置"];
        }
    }];
}

/*!
 *  打开本地照片，选择图片识别
 */
- (void)openLocalPhoto:(BOOL)allowsEditing
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    //部分机型有问题
    picker.allowsEditing = allowsEditing;
    
    
    [self presentViewController:picker animated:YES completion:nil];


}

//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak __typeof(self) weakSelf = self;
    
    [ZXingWrapper recognizeImage:image block:^(ZXBarcodeFormat barcodeFormat, NSString *str) {
        
        LBXScanResult *result = [[LBXScanResult alloc]init];
        result.strScanned = str;
        result.imgScanned = image;
        result.strBarCodeType = [self convertZXBarcodeFormat:barcodeFormat];
        
        [weakSelf scanResultWithArray:@[result]];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)closeview:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
