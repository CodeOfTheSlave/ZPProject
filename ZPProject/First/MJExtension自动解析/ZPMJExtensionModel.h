//
//  ZPMJExtensionModel.h
//  ZPProject
//
//  Created by lizp on 16/6/18.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "ZPMJImagesModel.h"

@interface ZPMJExtensionModel : NSObject

@property (nonatomic,copy) NSString *alt;
@property (nonatomic,copy) NSString *alt_title;

@property (nonatomic,strong) ZPMJImagesModel *images;

@property (nonatomic,copy) NSString *binding;
@property (nonatomic,copy) NSString *bookId;//id


+(NSDictionary *)mj_replacedKeyFromPropertyName;



@end
