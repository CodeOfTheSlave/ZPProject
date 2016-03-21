//
//  ZPFirstJSONModel.h
//  ZPProject
//
//  Created by 李志鹏 on 16/3/19.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZPImagesJSONModel.h"


//该数据  当解析中有字典或数组 需要遵循该协议
@protocol ZPFirstJSONModel

@end

@interface ZPFirstJSONModel : JSONModel<NSCopying,NSCoding,NSSecureCoding>

@property (nonatomic,copy) NSString<Optional> *yyyy ;
@property (nonatomic,copy) NSString<Optional> *alt_title;
@property (nonatomic,strong) ZPImagesJSONModel<ZPImagesJSONModel>  *images;
@property (nonatomic,strong) NSArray<ZPFirstJSONModel> *author;
@property (nonatomic,copy) NSString *medium;



@property (nonatomic,copy) NSString<Optional> *ddddd;
//Optional   可选属性    当网络未返回该字典也不会抛出异常   如ddddd

//此方法可以 用于当网络返回的数据与系统关键字冲突的时候 自己定义属性代替该字段  
+(JSONKeyMapper *)keyMapper;


@end
