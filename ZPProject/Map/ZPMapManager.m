//
//  ZPMapManager.m
//  ZPProject
//
//  Created by lizp on 16/8/8.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPMapManager.h"
#import "BMKMapManager.h"


@interface ZPMapManager()<BMKGeneralDelegate,CLLocationManagerDelegate>

@end

@implementation ZPMapManager

+(ZPMapManager *)shareInstance {
    static ZPMapManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZPMapManager alloc] init];
    });
    return manager;
}


-(void)start {
    
    NSString *mapKey = @"FEAUcrfePf7MbyisTClGlyVa2ugP5l9D";
    BMKMapManager *manager = [[BMKMapManager alloc] init];
    BOOL isStart =[manager start:mapKey generalDelegate:self];
    NSLog(@"%d",isStart);
    
}


-(BOOL)locationServiceEnabled {
    return [CLLocationManager locationServicesEnabled];
}

-(BOOL)cheakLocationServer {

   CLAuthorizationStatus status = [CLLocationManager authorizationStatus];//返回调用应用程序的当前授权状态。
    BOOL result = NO;
    switch (status) {
        case kCLAuthorizationStatusNotDetermined://用户还没做出是否要允许应用使用定位功能的决定
             kCLAuthorizationStatusRestricted:// 无法使用定位服务，该状态用户无法改变
             kCLAuthorizationStatusDenied:// 用户拒绝该应用使用定位服务，或是定位服务总开关处于关闭状态
            result = NO;
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways://定位服务授权状态已经被用户允许在任何状态下获取位置信息
             kCLAuthorizationStatusAuthorizedWhenInUse://定位服务授权状态仅被允许在使用应用程序的时候
             kCLAuthorizationStatusAuthorized://这个枚举值已经被废弃了。他相当于kCLAuthorizationStatusAuthorizedAlways这个值
            result = YES;
        default:
            break;
    }
    
    return result;
    
}


-(CLAuthorizationStatus)obtainLocationStatus {
//        kCLAuthorizationStatusNotDetermined,//用户还没做出是否要允许应用使用定位功能的决定
//        kCLAuthorizationStatusRestricted,// 无法使用定位服务，该状态用户无法改变
//        kCLAuthorizationStatusDenied,// 用户拒绝该应用使用定位服务，或是定位服务总开关处于关闭状态
//        kCLAuthorizationStatusAuthorizedAlways,//定位服务授权状态已经被用户允许在任何状态下获取位置信息
//        kCLAuthorizationStatusAuthorizedWhenInUse,//定位服务授权状态仅被允许在使用应用程序的时候。
//        kCLAuthorizationStatusAuthorized,//这个枚举值已经被废弃了。他相当于kCLAuthorizationStatusAuthorizedAlways这个值
    return [CLLocationManager authorizationStatus];
}


//-(void)returnLocationInfo:(locationBlock)locationBlock {
//
//    CLLocationManager *locationManager = [[CLLocationManager alloc]init ];
//    locationManager.delegate = self;
//    
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [locationManager startUpdatingLocation];
//    
//}

#pragma mark- CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"经度：%g",newLocation.coordinate.latitude);
    NSLog(@"纬度：%g",newLocation.coordinate.longitude);
}

#pragma mark- BMKGeneralDelegate
-(void)onGetNetworkState:(int)iError {
    if(iError == 0) {
        NSLog(@"connext to network is success:%d",iError);
    }else {
        NSLog(@"connext to network is fail:%d",iError);
    }
    
}

-(void)onGetPermissionState:(int)iError {
    if(iError == 0) {
        NSLog(@"start baiduMap service success:%d",iError);
    }else {
         NSLog(@"start baiduMap service fail:%d",iError);
    }
}

@end
