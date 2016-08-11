//
//  ZPMapManager.h
//  ZPProject
//
//  Created by lizp on 16/8/8.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPMapManager : NSObject

+(ZPMapManager *)shareInstance;

/**
 *  启动百度地图引擎
 */
-(void)start;


/**
 *  检查定位服务是否打开
 *
 *  @return YES 可用  NO 不可用
 */
-(BOOL)cheakLocationServer;





@end
