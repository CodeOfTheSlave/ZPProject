//
//  ZPFirstGETViewController.m
//  ZPProject
//
//  Created by 李志鹏 on 16/3/15.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPFirstGETViewController.h"

@interface ZPFirstGETViewController ()

@end

@implementation ZPFirstGETViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"GET请求";
    
#pragma mark - GET
        [ZPNetworking GET:@"https://api.douban.com/v2/book/search" parameter:@{@"q":@"5"} result:^(id responseObject, NSError *error) {
            NSLog(@">>>>>>>>>>>>>get请求回调");
        } isIndicator:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
