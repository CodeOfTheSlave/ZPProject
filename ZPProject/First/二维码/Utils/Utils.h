//
//  Utils.h
//
//  Created by lizp on 16/6/27.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject

/**
 *功能：判断字符串是否为null
 *@param
 * NSString     string    要判断的字符串
 *返回：布尔值
 */
+ (BOOL)isBlankString:(NSString*)string;

/**
 *功能：判断数组是否为null
 *@param
 * Array     param    要判断的数组
 *返回：布尔值
 */
+ (BOOL)checkArrayInvalid:(id)param;

/**
 *功能：判断字典是否为null
 *@param
 * Dictionary     param    要判断的字典
 *返回：布尔值
 */
+ (BOOL)checkDictionaryInvalid:(id)param;


@end
