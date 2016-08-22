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
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 400, kScreenWidth-100, 50);
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}

-(void)btnClick {
    
  //定位当前位置
    [[ZPMapManager shareInstance] returnLocationInfo:^(CLLocation *location) {
        if(location) {
            NSLog(@"定位成功:%@",location);
            self.locationLabel.text = [NSString stringWithFormat:@"经度 纬度 :%f,%f",location.coordinate.longitude,location.coordinate.latitude];
        }else {
            NSLog(@"定位失败");
            self.locationLabel.text = [NSString stringWithFormat:@"经度 纬度 :null"];
        }
        
        [[ZPMapManager shareInstance] reverseGeocode:location];
    }];
    
    

}


@end
