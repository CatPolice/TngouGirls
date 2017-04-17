//
//  APIManager.m
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "APIManager.h"
#import "Constant.h"
#import "AFSecurityPolicy.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "NSDictionary+JKJSONString.h"
#import "JKAlert.h"

static dispatch_once_t onceToken;
static APIManager *_sharedManager = nil;

@implementation APIManager
+ (instancetype)sharedManager {
    
    dispatch_once(&onceToken, ^{
        //设置服务器根地址
        _sharedManager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:URI_BASE_SERVER]];
        //        [_sharedManager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        
        AFSecurityPolicy * securityPolicy = [AFSecurityPolicy  defaultPolicy];
        //        securityPolicy.allowInvalidCertificates = YES;
        
        //        securityPolicy.validatesDomainName = NO;
        
        [_sharedManager setSecurityPolicy:securityPolicy];
        
        [_sharedManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"3G网络已连接");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"WiFi网络已连接");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"网络连接失败");
                    break;
                    
                default:
                    break;
            }
        }];
        [_sharedManager.reachabilityManager startMonitoring];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        //发送http数据
        _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //响应json数据
        _sharedManager.responseSerializer  = [AFJSONResponseSerializer serializer];
        
        _sharedManager.responseSerializer.acceptableContentTypes =  [_sharedManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
    });
    
    
    return _sharedManager;
}



+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLResponse *respone, id responseObject))success
                           failure:(void (^)(NSURLResponse *respone, NSError *error))failure{
    APIManager *manager = [APIManager sharedManager];
    
    NSLog(@"client request POST interface:\n%@",URLString);
    
    NSLog(@"client request POST JSON:\n%@",[parameters?:@{} jk_JSONString]);
    
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"server respone  JSON:\n%@",[responseObject jk_JSONString]);
        if (![responseObject objectForKey:@"error"]) {
            success(task.response,responseObject);
        }else{
            [JKAlert showMessage:[responseObject objectForKey:[@"error" description]]];
            NSError *errorForJSON = [NSError errorWithDomain:@"接口出错" code:2015 userInfo:@{@"接口请求失败": [responseObject objectForKey:@"errorMsg"]?:@""}];
            NSLog(@"error%@",[errorForJSON description]);
            failure(task.response,errorForJSON);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"server respone  Error JSON:\n%@",responseString);
        
        failure(task.response,error);
    }];
}
+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLResponse *respone, id responseObject))success
                          failure:(void (^)(NSURLResponse *respone, NSError *error))failure{
    APIManager *manager = [APIManager sharedManager];
    NSLog(@"client request POST interface:%@",URLString);
    NSLog(@"client request POST JSON:\n%@",[parameters?:@{} jk_JSONString]);
    
    return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"server respone  JSON:\n%@",[responseObject jk_JSONString]);
        if (![responseObject objectForKey:@"error"]) {
            success(task.response,responseObject);
        }else{
            [JKAlert showMessage:[responseObject objectForKey:@"error"]];
            NSError *errorForJSON = [NSError errorWithDomain:@"接口出错" code:2015 userInfo:@{@"接口请求失败": [responseObject objectForKey:@"errorMsg"]?:@""}];
            NSLog(@"error%@",[errorForJSON description]);
            failure(task.response,errorForJSON);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo
        failure(task.response,error);
    }];
}

@end

