//
//  ZPFirstViewController.m
//  ZPProject
//
//  Created by 李志鹏 on 16/3/13.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPFirstViewController.h"

@interface ZPFirstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSArray *classArray ;

@end

@implementation ZPFirstViewController

#pragma mark - 懒加载
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return  _tableView;
}

- (NSArray *)dataSource {
    if(_dataSource == nil) {
        _dataSource = @[@"GET",@"POST",@"JSONModel"];
    }
    return _dataSource;
}

- (NSArray *)classArray {
    if(_classArray == nil) {
        _classArray = @[@"ZPFirstGETViewController",@"ZPFirstPOSTViewController",@"ZPJSONModelViewController"];
    }
    return _classArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID  = @"cell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class className = NSClassFromString(self.classArray[indexPath.row]);
    UIViewController *nextVC = [[className alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
