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
    [self logPrintRequest:url parameter:parameter];
    [self.manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
        result ? result(responseObject,nil) : nil;
        [self logSuccessResult:responseObject];
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
    [self logPrintRequest:url parameter:parameter];
    
    [self.manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
        result ? result(responseObject,nil) : nil;
        [self logSuccessResult:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result ? result(nil,error) : nil;
        [self logErrorInfo:error];
    }];
    

    
}

#pragma mark - 打印请求连接  
- (void)logPrintRequest:(NSString *)url parameter:(id)parameter {
    if(!parameter) {
        NSLog(@"****************打印请求链接************************");
        NSLog(@">>>>>>>>>>>>>url: %@ \n<<<<<<<<<<<<<<<",url);
        NSLog(@"****************请求链接打印结束************************");
    }
    
    if([parameter isKindOfClass:[NSDictionary class]]  || [parameter isKindOfClass:[NSMutableDictionary class]] ){
        NSLog(@"****************打印请求链接************************");
        NSString *urlStr = @"";
        for (NSString *key in [parameter allKeys]) {
            urlStr = [NSString stringWithFormat:@"%@=%@&",key,parameter[key]];
        }
        if([urlStr hasSuffix:@"?"] || [urlStr hasSuffix:@"&"]){
            urlStr = [urlStr substringToIndex:urlStr.length-1];
        }
        NSLog(@">>>>>>>>>>>>>url: %@?%@ \n<<<<<<<<<<<<<<<",url,urlStr);
        NSLog(@"****************请求链接打印结束************************");
    }
}

#pragma mark - 打印错误信息 
- (void)logErrorInfo:(NSError *)error {
    NSLog(@"*************打印错误信息*****************\n%@",error);
    NSLog(@"*************错误信息打印完毕***************\n");
}

#pragma mark - 打印请求结果
- (void)logSuccessResult:(id)result {
    NSLog(@"*************打印请求结果*****************\n");
    NSLog(@">>>>>>>>>>>\n %@ \n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<",result);
    NSLog(@"*************请求结果打印完毕***************\n");
}



@end
