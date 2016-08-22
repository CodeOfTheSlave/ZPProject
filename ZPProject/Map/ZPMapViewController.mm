//
//  ZPMapViewController.m
//
//  Created by lizp on 16/8/9.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPMapViewController.h"
#import "ZPMapManager.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface ZPMapViewController ()

@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UILabel *locationAddress;

@end

@implementation ZPMapViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"baiduMap";
    self.view.backgroundColor = kDefaultVCBackgroundColor;
    
    
    ZPMapManager *manager = [ZPMapManager shareInstance];
    [manager start];
    
    
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, kScreenWidth -100, 30)];
    self.locationLabel.backgroundColor = [UIColor lightGrayColor];
    self.locationLabel.text = @"经度 纬度 :";
    [self.view addSubview:self.locationLabel];
    
    self.locationAddress = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, kScreenWidth -100, 30)];
    self.locationAddress.backgroundColor = [UIColor lightGrayColor];
    self.locationAddress.text = @"定位地址:";
    [self.view addSubview:self.locationAddress];
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 300, kScreenWidth-100, 50);
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btnAddress =[UIButton buttonWithType:UIButtonTypeCustom];
    btnAddress.backgroundColor = [UIColor redColor];
    btnAddress.frame = CGRectMake(50, 400, kScreenWidth-100, 50);
    [btnAddress setTitle:@"定位地址信息" forState:UIControlStateNormal];
    [btnAddress addTarget:self action:@selector(btnAddressClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAddress];
    
    
}

-(void)btnClick {
    
    __weak typeof(self) weakSelf = self;
  //定位当前位置
    [[ZPMapManager shareInstance] returnLocationInfo:^(CLLocation *location) {
        if(location) {
            NSLog(@"定位成功:%@",location);
            weakSelf.locationLabel.text = [NSString stringWithFormat:@"经度 纬度 :%f,%f",location.coordinate.longitude,location.coordinate.latitude];
        }else {
            NSLog(@"定位失败");
            weakSelf.locationLabel.text = [NSString stringWithFormat:@"经度 纬度 :null"];
        }
    }];
    
    
    

}

-(void)btnAddressClick {

    __weak typeof(self) weakSelf = self;
    //获取当前位置地址
    [[ZPMapManager shareInstance] returnLocationAddress:^(NSString *address) {
        if(address) {
            weakSelf.locationAddress.text = [NSString stringWithFormat:@"定位地址:%@",address];
            NSLog(@"获取当前位置地址成功");
        }else {
            weakSelf.locationAddress.text = [NSString stringWithFormat:@"定位地址:null"];
            NSLog(@"获取当前位置地址失败");
        }
        
    }];
}


@end
