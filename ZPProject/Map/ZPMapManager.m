//
//  ZPMapManager.m
//  ZPProject
//
//  Created by lizp on 16/8/8.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPMapManager.h"
#import "BMKMapManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ZPMapManager()<BMKGeneralDelegate>

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

-(BOOL)cheakLocationServer {

    BOOL isServer = [CLLocationManager locationServicesEnabled];
    return isServer;
}

#pragma private

#pragma mark- 定位服务是否开启
-(BOOL)locationServiceEnabled {
    return [CLLocationManager locationServicesEnabled];
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
