//
//  ZPMapManager.m
//  ZPProject
//
//  Created by lizp on 16/8/8.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPMapManager.h"
#import "BMKMapManager.h"

@interface ZPMapManager()<BMKGeneralDelegate>

@end

@implementation ZPMapManager

+(ZPMapManager *)shareInstance {
    static ZPMapManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZPMapManager alloc] init];
    });
    return manager;
}

-(void)start {
    
    NSString *mapKey = @"FEAUcrfePf7MbyisTClGlyVa2ugP5l9D";
    BOOL isStart = [[BMKMapManager alloc] start:mapKey generalDelegate:self];
    NSLog(@"%d",isStart);
}


#pragma mark- BMKGeneralDelegate
-(void)onGetNetworkState:(int)iError {
    NSLog(@"onGetNetworkState:%d",iError);
}

-(void)onGetPermissionState:(int)iError {
     NSLog(@"onGetPermissionState:%d",iError);
}

@end
