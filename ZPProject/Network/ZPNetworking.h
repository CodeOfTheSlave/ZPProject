//
//  ZPNetworking.h
//  ZPProject
//
//  Created by 李志鹏 on 16/3/13.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^resultBlock)(id responseObject,NSError *error);


@interface ZPNetworking : NSObject

@property (nonatomic,weak) resultBlock successs;


+ (void)GETWithUrl:(NSString *)url parameter:(id)parameter result:(resultBlock)result isIndicator:(BOOL)isIndicator;

@end
