//
//  ZPThreeViewController.m
//  ZPProject
//
//  Created by 李志鹏 on 16/3/13.
//  Copyright © 2016年 LZP. All rights reserved.
//

#import "ZPThreeViewController.h"

@interface ZPThreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NSArray *classData;

@end

@implementation ZPThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma  mark- tableView data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark- tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
}


#pragma mark - 懒加载
-(UITableView *)tableView {

    if(!_tableView) {
    
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSArray *)data {

    if(!_data) {
        _data = @[
                  ];
    }
    return _data;
}

-(NSArray *)classData {

    if(!_classData) {
        _classData = @[];
    }
    return _classData;
}

@end
