//
//  GYAddressCityModel.h
//  HSConsumer
//
//  Created by lizp on 16/6/2.
//  Copyright © 2016年 SHENZHEN GUIYI SCIENCE AND TECHNOLOGY DEVELOP CO.,LTD. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GYAddressCityModel : JSONModel

@property (nonatomic,copy) NSString <Optional>*cityNameCn;
@property (nonatomic,copy) NSString <Optional>*cityNo;
@property (nonatomic,copy) NSString <Optional>*cityFullName;
@property (nonatomic,copy) NSString <Optional>*delFlag;
@property (nonatomic,copy) NSString <Optional>*population;
@property (nonatomic,copy) NSString <Optional>*postCode;
@property (nonatomic,copy) NSString <Optional>*countryNo;
@property (nonatomic,copy) NSString <Optional>*version;
@property (nonatomic,copy) NSString <Optional>*phonePrefix;
@property (nonatomic,copy) NSString <Optional>*provinceNo;
@property (nonatomic,copy) NSString <Optional>*cityName;

@end
