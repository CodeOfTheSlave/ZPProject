//
//  Utils.m
//
//  Created by lizp on 16/6/27.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "Utils.h"

@implementation Utils


+ (BOOL)isBlankString:(NSString*)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkArrayInvalid:(id)param
{
    if ([self checkObjectInvalid:param] || [param isKindOfClass:[NSArray class]] == NO) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)checkDictionaryInvalid:(id)param
{
    if ([self checkObjectInvalid:param] || [param isKindOfClass:[NSDictionary class]] == NO) {
        return YES;
    }
    
    return NO;
}


+ (BOOL)checkObjectInvalid:(id)param
{
    if ((!param) || ([param isEqual:[NSNull null]])) {
        return YES;
    }
    
    return NO;
}



@end
