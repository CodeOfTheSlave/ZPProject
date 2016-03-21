//
//  ZPImagesJSONModel.h
//  ZPProject
//
//  Created by 李志鹏 on 16/3/19.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol  ZPImagesJSONModel


@end

@interface ZPImagesJSONModel : JSONModel





@property (nonatomic,copy) NSString *large ;
@property (nonatomic,copy) NSString *medium ;
@property (nonatomic,copy) NSString *small ;


@end
