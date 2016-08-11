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
    [self initView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"Show Controller: %@", [self class]);

}

- (void)dealloc {
    NSLog(@"Dealloc Controller: %@", [self class]);
}

// #pragma mark - SystemDelegate   
// #pragma mark TableView Delegate    
// #pragma mark - CustomDelegate  
// #pragma mark - event response  

#pragma mark - private methods 
- (void)initView
{
    self.title = @"baiduMap";
    self.view.backgroundColor = kDefaultVCBackgroundColor;
    NSLog(@"Load Controller: %@", [self class]);
    
    ZPMapManager *manager = [ZPMapManager shareInstance];
    [manager start];
}

#pragma mark - getters and setters  


@end
