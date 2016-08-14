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

@property (nonatomic,strong) CLLocationManager  *locationManager;



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
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
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



-(void)returnLocationInfo:(locationBlock)locationBlock {
    
    if(!locationBlock) {
        return;
    }
    
    if([self cheakLocationServer]) {
        self.locationInfo = locationBlock;
        [self.locationManager startUpdatingLocation];
    }else {
        NSLog(@"定位服务没开启:请在设置—隐私-定位服务中打开");
    }
    
    
}


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

#pragma mar- CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    if(self.locationInfo) {
        self.locationInfo(locations[0]);
    }
    CLLocation *location = locations[0];
    NSLog(@"纬度:%f    经度:%f   ",location.coordinate.latitude,location.coordinate.longitude);
    //速度
    if(location.speed > 0) {
        NSLog(@"速度:%f",location.speed);
    }else {
        NSLog(@"速度无效");
    }
    
    
    //*范围：
    //* 0 - 359.9度，0是真正的北方
    if(location.course < 0 || location.course > 359.9) {
        NSLog(@"航向无效");
    }else {
        NSLog(@"航向:%f",location.course);
    }
}


#pragma mark- 懒加载
-(CLLocationManager *)locationManager {

    if(!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    }
    return _locationManager;
}

@end
