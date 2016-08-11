//
//  ZPMapManager.h
//  ZPProject
//
//  Created by lizp on 16/8/8.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>



typedef void(^locationBlock)(CLLocation *);

@interface ZPMapManager : NSObject



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


///**
// *  获取定位的经度、纬度信息
// */
//-(void)returnLocationInfo:(locationBlock)locationBlock;





@end
