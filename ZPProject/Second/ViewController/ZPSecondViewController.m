//
//  ZPSecondViewController.m
//  ZPProject
//
//  Created by lizp on 16/3/13.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPSecondViewController.h"

@interface ZPSecondViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NSArray *classData;

@end

@implementation ZPSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUp];
}

#pragma mark- pravite 
-(void)setUp {
    
    [self.view addSubview:self.tableView];
}

#pragma mark- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

#pragma mark- UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class class = NSClassFromString(self.classData[indexPath.row]);
    UIViewController *VC = [[class alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark- 懒加载
-(UITableView *)tableView {

    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSArray *)data {
    if(!_data) {
        _data = @[@"baiduMap"];
    }
    return _data;
}

-(NSArray *)classData {
    if(!_classData) {
        _classData = @[@"ZPMapViewController"];
    }
    return _classData;
}

@end
