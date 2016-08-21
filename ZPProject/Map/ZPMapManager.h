//
//  ZPMapManager.h
//  ZPProject
//
//  Created by lizp on 16/8/8.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>




typedef void(^locationBlock)(CLLocation *location);

@interface ZPMapManager : NSObject

@property (nonatomic,copy) locationBlock locationInfo;


+(ZPMapManager *)shareInstance;

/**
 *  启动百度地图引擎
 */
-(void)start;


/**
 *  系统定位服务是否开启 （设置-隐私-定位服务  是否打开）
 */
-(BOOL)locationServiceEnabled;


/**
 *  检查定位服务是否打开
 *
 *  @return YES 可用  NO 不可用
 */
-(BOOL)cheakLocationServer;


/**
 *  检查定位服务状态
 *
 *  @return 定位服务状态
 */
-(CLAuthorizationStatus)obtainLocationStatus;


/**
 *  通过Block回调返回定位信息 CLLocation （包含经度、纬度、速度、航向）
 */
-(void)returnLocationInfo:(locationBlock)locationBlock;



@end
