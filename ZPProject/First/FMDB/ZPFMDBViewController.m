//
//  ZPFMDBViewController.m
//  ZPProject
//
//  Created by lizp on 16/6/3.
//  Copyright © 2016年 Apple05. All rights reserved.
//

#import "ZPFMDBViewController.h"
#import "AFNetworking.h"
#import "AFURLSessionManager.h"
//#import "AFHTTPRequestOperationManager.h"®
#import "GYFMDBAddressProvinceManager.h"
#import "GYFMDBAddressCityManager.h"
#import "GYAddressCityModel.h"
#import "GYAddressProvinceModel.h"

@interface ZPFMDBViewController ()


@end

@implementation ZPFMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self localData];
//    [self networkRequest];
}


-(void)localData {
    NSString *dataPath  = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSString *dataString = [NSString stringWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    GYFMDBAddressProvinceManager *provinceManager = [GYFMDBAddressProvinceManager shareInstance];
    GYFMDBAddressCityManager *cityManager = [GYFMDBAddressCityManager shareInstance];
    for (NSDictionary *dataDic in dic[@"data"]) {
        
        for (NSDictionary *cityDic in dataDic[@"citys"]) {
            GYAddressCityModel *cityModel = [[GYAddressCityModel alloc] initWithDictionary:cityDic error:nil];
            [cityManager insertCity:cityModel];
        }
        
        GYAddressProvinceModel *modelProvince = [[GYAddressProvinceModel alloc] initWithDictionary:dataDic[@"province"] error:nil];
        [provinceManager insertProvince:modelProvince];
        
    }

    

    

}

//网络数据
-(void)networkRequest {
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager GET:@"https://dc.aadv.net/mobile/reconsitution/lcs/queryProvinceTree"  parameters:@{@"countryNo":@"156"}  progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


@end
