//
//  ZPJSONModelViewController.m
//  ZPProject
//
//  Created by 李志鹏 on 16/3/19.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPJSONModelViewController.h"
#import "ZPFirstJSONModel.h"


@interface ZPJSONModelViewController ()

@property (nonatomic,copy)  NSString *path;

@end

@implementation ZPJSONModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ZPNetworking GET:@"https://api.douban.com/v2/book/search" parameter:@{@"q":@"5"} result:^(id responseObject, NSError *error) {

#pragma mark - 自动解析模型
        ZPFirstJSONModel *model =  [[ZPFirstJSONModel alloc] initWithDictionary:responseObject[@"books"][0] error:nil];
        NSLog(@"%@==",model.ddddd);
#pragma   JSONModel 转化成字典
        NSDictionary *dict = [model toDictionary];
         NSLog(@"%@==",dict );
        
#pragma JSONModel 转换成 json字符串
        NSString *str = [model toJSONString];
        NSLog(@"%@==",str);
        
#pragma mark -  归档数据（缓存数据）
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        //沙盒路径
        self.path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        self.path = [NSString stringWithFormat:@"%@JSONModelData",self.path];
        [data writeToFile:self.path atomically:NO];
        
         NSLog(@"====%@",model.alt_title);
        
    } isIndicator:YES];
    
    
    
    [self setUp];
    
}

- (void)setUp {
    
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)btnClick {
#pragma mark - 取去归档数据（缓存数据）
    NSData *data = [NSData dataWithContentsOfFile:self.path ];
    ZPFirstJSONModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"====%@",model.alt_title);
}


@end
