//
//  ZPScanRelustViewController.m
//  ZPProject
//
//  Created by lizp on 16/6/23.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPScanResultViewController.h"

@interface ZPScanResultViewController ()

@end

@implementation ZPScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *lbResult = [[UILabel alloc ]initWithFrame:self.view.bounds];
    lbResult.backgroundColor = [UIColor lightGrayColor];
    lbResult.text = self.relust;
    [self.view addSubview:lbResult];
}




@end
