//
//  ZPFirstJSONModel.m
//  ZPProject
//
//  Created by 李志鹏 on 16/3/19.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPFirstJSONModel.h"

@implementation ZPFirstJSONModel


+(JSONKeyMapper *)keyMapper {

    //用yyyy属性代替网络返回的字段
    //层级关系（数组和字典都可以）可在同一model中定义不同层级的属性（images下的medium由medium属性接收）  如数组  images =     {
//    large = "https://img1.doubanio.com/lpic/s4476867.jpg";
//    medium = "https://img1.doubanio.com/mpic/s4476867.jpg";
//    small = "https://img1.doubanio.com/spic/s4476867.jpg";
//};
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"alt":@"yyyy",@"images.medium":@"medium"}];
}
            



@end
