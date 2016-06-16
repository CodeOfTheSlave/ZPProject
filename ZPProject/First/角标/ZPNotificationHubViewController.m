//
//  ZPNotificationHubViewController.m
//  ZPProject
//
//  Created by lizp on 16/6/16.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPNotificationHubViewController.h"
#import "ZPNotificationHub.h"

@interface ZPNotificationHubViewController ()

@end

@implementation ZPNotificationHubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:view];
    
    ZPNotificationHub *hub = [[ZPNotificationHub alloc] initWithView:view];
    hub.count = 23;
    [hub showCount];
}



@end
