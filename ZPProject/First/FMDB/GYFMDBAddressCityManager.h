//
//  GYFMDBAddressCityManager.h
//  HSConsumer
//
//  Created by lizp on 16/6/1.
//  Copyright © 2016年 SHENZHEN GUIYI SCIENCE AND TECHNOLOGY DEVELOP CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GYAddressCityModel;
@interface GYFMDBAddressCityManager : NSObject

#pragma mark - 零售
+(GYFMDBAddressCityManager *)shareInstance;
-(instancetype)init;
-(void)insertCity:(GYAddressCityModel *)model;
-(NSArray *)executeCity:(NSString *)province;
-(void)deleteCity;

#pragma mark - 餐饮
@end
