//
//  ZPMJExtensionViewController.m
//  ZPProject
//
//  Created by lizp on 16/6/18.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPMJExtensionViewController.h"
#import "MJExtension.h"
#import "ZPMJExtensionModel.h"


@interface ZPMJExtensionViewController ()

@end

@implementation ZPMJExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [ZPNetworking GET:@"https://api.douban.com/v2/book/search" parameter:@{@"q":@"5"} result:^(id responseObject, NSError *error) {
        ZPMJExtensionModel *model = [ZPMJExtensionModel mj_objectWithKeyValues:responseObject[@"books"][0]];
        NSLog(@"%@====%@====%@======%@===========%@======%@",model.alt_title,model.alt,model.binding,model.bookId,model.images,model.images.large);
        
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
