//
//  FSPNetworkTools.m
//  reviewKnowleage
//
//  Created by fushp on 2018/12/17.
//  Copyright © 2018年 fushp. All rights reserved.
//

#import "FSPNetworkTools.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension.h>
#import "FSPUrlMacro.h"
#import "FSPTimeDataTools.h"

#define BASEURL @"http://www.doclever.cn:8090"

@implementation FSPNetworkTools
static AFHTTPSessionManager *_sessionManager;
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    NSURL * baseUrl = [[NSURL alloc] initWithString:BASEURL];
    _sessionManager = [_sessionManager initWithBaseURL:baseUrl];
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _sessionManager.requestSerializer.timeoutInterval = 30.f;// 请求超时时间设置
    [_sessionManager setSecurityPolicy:[self customSecurityPolicy]];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
}

+ (void)post:(NSString *)url
  andPragram:(NSDictionary *)BodyPragram
   modelName:(NSString*)modelName
   modelType:(EnumModelType)modelType
successBlock:(void(^)(id model))successBlock
   failBlock:(void (^)(NSURLSessionDataTask *task, id error))fail {
    // 取当前显示的控制器的view
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [QMUITips showLoading:@"数据加载中..." inView:keyWindow];
    //拼接消息
    NSDictionary *head = [self createHeaderDictWithCmdType:nil];
    NSDictionary *pragram = @{kHead:head,kBody:BodyPragram};
    
//    __weak __typeof(self)weakSelf = self;
    [self manager:_sessionManager  post:url andPragram:pragram successBlock:^(NSURLSessionDataTask *task, id responObject) {
        QMUILog(@"post::",@"%@",responObject);
        [QMUITips hideAllTips];
        // 这个输出 是方便从中控中查阅
        NSInteger resDescNum = [responObject[kHead][kResCode] integerValue];
        //402 远程控制
        if (resDescNum != 200 && resDescNum != 202 && resDescNum != 411 && resDescNum != 402) {
//            [QMUITips showWithText:responObject[kHeader][kResDesc]];
            return;
        }
        
        // 通过上面的if语句 下面所有回调都会是成功的
        [self translationData:responObject modelName:modelName onlyAnalysis:kBody resultBlock:successBlock];
        
//        model(responObject);
    } failBlock:^(NSURLSessionDataTask *task, NSError *data) {
        
//
        /*注意:这里要强转下*/
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        
        if (responses.statusCode == 602 ) { //被另一手机登录踢出
//            [weakself backLoginVc:@"您的账号已经在其他设备登录,请重新登录"];
            return ;
        }else if(responses.statusCode == 601){//超时失效
//            [weakself backLoginVc:@"登录过期,请重新登录"];
            return ;
            
        }
        
        
       
//        [SEMIShowHUD showHUDWithWarringText:data.userInfo[@"NSLocalizedDescription"] addView:keyWindow];
//
//        BKLog(@"-failURL--->%@--error--->%@\nPragram--->%@\n",url,data.localizedDescription,pragram);
//        // 失败回调  不再回传
        
    }];
}

+ (NSURLSessionDataTask *)manager:(AFHTTPSessionManager *)manager
                             post:(NSString *)url
                       andPragram:(NSDictionary *)pragram
                     successBlock:(void (^)(NSURLSessionDataTask *, id))success
                        failBlock:(void (^)(NSURLSessionDataTask *, id))fail
{
    
    return [manager POST:url parameters:pragram progress:nil success:success failure:fail];
}

// 数据解析 转化 回调
+ (void)translationData:(NSDictionary *)responObject modelName:(NSString *)modelName onlyAnalysis:(NSString *)field resultBlock:(void(^)(id))model
{
    
    if (modelName == nil) { // 没有模型 不需要解析
        if (field == nil) { // 没有指定解析的字段
            dispatch_async(dispatch_get_main_queue(), ^{
                model(responObject); // 返回服务器的数据
            });
        }else { // 有指定需要解析的字段
            // 遍历服务器的数据 把服务器返回的字典数据 第一层级的key 和指定需要解析的字段比较 找出指定解析的字段 将字段值返回
            [responObject enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isEqualToString:field]) { //
                    dispatch_async(dispatch_get_main_queue(), ^{
                        model(obj); // 返回找到的字段值,因为没有传入模型 所以直接将字段值返回
                        *stop = YES;
                    });
                }
            }];
        }
    } else { // 有传入模型 需要解析成模型对象返回
        if (field == nil) { // 没有传入指定解析的字段 所以需要将服务器返回的数据全转换成模型对象
            model([NSClassFromString(modelName) mj_objectWithKeyValues:responObject]);
        }else { // 有指定解析的字段 需要找到该字段 并将字段对应的值进行模型转换
            [responObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if ([key isEqualToString:field]) {
                    id modelObj = [NSClassFromString(modelName) mj_objectWithKeyValues:obj];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        model(modelObj); // 转换找到的obj值 并回调
                        *stop = YES;
                    });
                }
            }];
        }
    }
}




+ (AFSecurityPolicy*)customSecurityPolicy {
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}

/* 添加业务消息头 */
+ (NSMutableDictionary *)createHeaderDictWithCmdType:(NSString *)cmdType {
    
    NSString *reqTime = [FSPTimeDataTools getCurrentDateWithFormatString:@"yyyyMMddHHmmss"];
    //  请求来源定义如下： 0-平台内部调用 1-车机端 2-手机APP 3-公众门户 4-车厂监控中心 5-运维管理平台 6-第三方平台
    NSString *source ;
    
    if ([source length] == 0) {
        source = @"2";
    }
    
    NSString *token = userManager.curUserInfo.token;
    NSString *tid = userManager.curUserInfo.tid;
    if (token ==nil) {
        token = @"";
    }
    if (tid ==nil) {
        tid = @"";
    }
    
   
    
    NSMutableDictionary *head = [NSMutableDictionary dictionary];
    [head setObject:reqTime forKey:kReqTime];
    [head setObject:source forKey:kSource];
    [head setObject:token forKey:kToken];
    [head setObject:tid forKey:kTid];
//    [head setObject:@"deviceType" forKey:kDeviceType];
//    [head setObject:cmdType forKey:@"cmdType"];
    return head;
}

@end
