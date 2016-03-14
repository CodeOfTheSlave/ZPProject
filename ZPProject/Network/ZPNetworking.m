//
//  ZPNetworking.m
//  ZPProject
//
//  Created by 李志鹏 on 16/3/13.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworkReachabilityManager.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"


@interface ZPNetworking()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation ZPNetworking

#pragma mark - 懒加载 
- (AFHTTPSessionManager *)manager
{
    if(_manager == nil){
        _manager = [[AFHTTPSessionManager alloc] init];
    }
    return _manager;
}

#pragma mark - 实例化
+ (ZPNetworking *)shareInstance
{
    static ZPNetworking *network  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[ZPNetworking alloc] init];
    });
    return network;
    
    
    
}

#pragma  mark - 检测网络变化
- (void)startMoniteringNetwork
{
    AFNetworkReachabilityManager *manager  = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];

    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别网络");
                break;
            
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络不可达");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G 3G 4G...网络");
                break;
            
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
                
            default:
                break;
        }
    }];
    [manager stopMonitoring];
}

#pragma mark GET请求
+ (void)GET:(NSString *)url parameter:(id)parameter result:(resultBlock)result isIndicator:(BOOL)isIndicator {
    [[self shareInstance] GET:url parameter:parameter result:result isIndicator:isIndicator];
    
}


- (void)GET:(NSString *)url parameter:(id)parameter result:(resultBlock)result isIndicator:(BOOL)isIndicator
{
    
    if(isIndicator) {
        [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:isIndicator];
    }
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer ];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self.manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
        result ? result(responseObject,nil) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result ? result(nil,error) : nil;
    }];
    
}


#pragma mark - POST 请求
+ (void)POST:(NSString *)url parameter:(id)parameter result:(resultBlock)result isIndicator:(BOOL)isIndicator
{
    [[self shareInstance] POST:url parameter:parameter result:result isIndicator:isIndicator];
}

- (void)POST:(NSString *)url parameter:(id)parameter result:(resultBlock)result isIndicator:(BOOL)isIndicator {
    if(isIndicator) {
        [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:isIndicator];
    }
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [self.manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
        result ? result(responseObject,nil) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result ? result(nil,error) : nil;
    }];
    
//    [self.manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
//        result ? result(responseObject,nil) : nil;
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
//        result ? result(responseObject,nil) : nil;
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        result ? result(nil,error) : nil;
//    }];
    
    
}



@end
