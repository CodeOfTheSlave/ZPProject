//
//  ZPMapViewController.m
//
//  Created by lizp on 16/8/9.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPMapViewController.h"
#import "ZPMapManager.h"

@interface ZPMapViewController ()



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
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 100, kScreenWidth-100, 50);
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClick {
    
    
    [[ZPMapManager shareInstance] returnLocationInfo:^(CLLocation *location) {
        if(location) {
            NSLog(@"定位成功:%@",location);
        }else {
            NSLog(@"定位失败");
        }
        
    }];
}







 




@end
