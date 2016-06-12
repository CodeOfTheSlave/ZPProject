//
//  GYFMDBAddressManager.h
//  HSConsumer
//
//  Created by lizp on 16/6/1.
//  Copyright © 2016年 SHENZHEN GUIYI SCIENCE AND TECHNOLOGY DEVELOP CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GYAddressProvinceModel;
@interface GYFMDBAddressProvinceManager : NSObject

#pragma mark - 零售
+(GYFMDBAddressProvinceManager *)shareInstance;
-(void)deleteProvince ;
-(NSArray *)executeProvince:(NSString *)countryNo ;
-(void)insertProvince:(GYAddressProvinceModel *)model;

#pragma mark - 餐饮


@end
