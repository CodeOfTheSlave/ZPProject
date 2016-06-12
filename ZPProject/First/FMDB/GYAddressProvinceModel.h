//
//  GYAddressProvinceModel.h
//  HSConsumer
//
//  Created by lizp on 16/6/1.
//  Copyright © 2016年 SHENZHEN GUIYI SCIENCE AND TECHNOLOGY DEVELOP CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface GYAddressProvinceModel : JSONModel

@property (nonatomic,copy) NSString <Optional>*countryNo;
@property (nonatomic,copy) NSString <Optional>*delFlag;
@property (nonatomic,copy) NSString <Optional>*directedCity;
@property (nonatomic,copy) NSString <Optional>*provinceName;
@property (nonatomic,copy) NSString <Optional>*provinceNameCn;
@property (nonatomic,copy) NSString <Optional>*provinceNo;
@property (nonatomic,copy) NSString <Optional>*version;

@end
