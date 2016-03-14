//
//  ZPFirstViewController.m
//  ZPProject
//
//  Created by 李志鹏 on 16/3/13.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPFirstViewController.h"

@interface ZPFirstViewController ()

@end

@implementation ZPFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark - GET
//    [ZPNetworking GET:@"https://api.douban.com/v2/book/search" parameter:@{@"q":@"5"} result:^(id responseObject, NSError *error) {
//        NSLog(@"444===%@",responseObject);
//    } isIndicator:YES];
    
#pragma mark - POST
    [ZPNetworking POST:@"https://api.douban.com/v2/book/6548683/collection" parameter:@{@"status":@"wish"} result:^(id responseObject, NSError *error) {
        NSLog(@"%@===",responseObject);
    } isIndicator:YES];
    
    
}



@end
