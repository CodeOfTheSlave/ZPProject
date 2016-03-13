//
//  ZPTabbarViewController.m
//  ZPProject
//
//  Created by 李志鹏 on 16/3/13.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPTabbarViewController.h"
#import "ZPFirstViewController.h"
#import "ZPSecondViewController.h"
#import "ZPThreeViewController.h"
#import "ZPFourViewController.h"
#import "AppDelegate.h"

@interface ZPTabbarViewController ()

@end

@implementation ZPTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self settingTabbar];
    
    
    
}


- (void) settingTabbar
{
    ZPFirstViewController *firstVC = [[ZPFirstViewController alloc] init];
    firstVC.title = @"first";
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    
    ZPSecondViewController *secondVC = [[ZPSecondViewController alloc] init];
    secondVC.title = @"second";
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    ZPThreeViewController *threeVC = [[ZPThreeViewController alloc] init];
    threeVC.title = @"three";
    UINavigationController *threeNav = [[UINavigationController alloc] initWithRootViewController:threeVC];
    
    ZPFourViewController *fourVC = [[ZPFourViewController alloc] init];
    fourVC.title     = @"four";
    UINavigationController *fourNav  = [[UINavigationController alloc] initWithRootViewController:fourVC];
    
    NSArray *VCArray = @[firstNav,secondNav,threeNav,fourNav];
    
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    tabbarVC.viewControllers = VCArray;

    [[UIApplication sharedApplication ].delegate window].rootViewController = tabbarVC;
    
    
}




@end
