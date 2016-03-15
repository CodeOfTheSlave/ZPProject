//
//  ZPFirstPOSTViewController.m
//  ZPProject
//
//  Created by 李志鹏 on 16/3/16.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPFirstPOSTViewController.h"

@interface ZPFirstPOSTViewController ()

@end

@implementation ZPFirstPOSTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"POST请求";
    
#pragma mark - POST
    [ZPNetworking POST:@"https://api.douban.com/v2/book/1220562" parameter:nil result:^(id responseObject, NSError *error) {
        
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
