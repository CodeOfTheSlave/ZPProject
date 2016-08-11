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
 *  启动引擎
 */
-(void)start;

@end
