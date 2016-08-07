//
//  ZPCoreDataRelationViewController.m
//  ZPProject
//
//  Created by lizp on 16/5/4.
//  Copyright © 2016年 Apple05. All rights reserved.
//

#import "ZPCoreDataRelationViewController.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Department.h"


@interface ZPCoreDataRelationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSManagedObjectContext *context;
@property (nonatomic,strong) UITableView *tableView ;
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) UITextField *textField ;
@property (nonatomic,strong)  Person *selectPerson;
@end

@implementation ZPCoreDataRelationViewController

#pragma mark -  懒加载  
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 134, kScreenWidth, kScreenHeight -20-134) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建数据库文件
    //添加实体 (数据库表)
    //添加实体模型  （model）
    //生成上下文
    
//    self.context = [[NSManagedObjectContext alloc] init];
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    //数据持久化 调度器
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingString:@"gy.sqlite"];
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil];
    
    self.context.persistentStoreCoordinator = store;
    
    [self setUp];
    
}

- (void)setUp {

    NSArray *arr = @[@"增",@"查",@"改",@"删"];
    for (NSInteger i = 0 ; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*kScreenWidth/4, 64, kScreenWidth/4, 40);
        btn.backgroundColor = kDefaultVCBackgroundColor;
        [btn setTitle:arr[i]  forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal ];
        btn.tag = 100 +i;
//        btn.titleLabel.text = arr[i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, 30)];
    self.textField.backgroundColor = [UIColor lightGrayColor];
    self.textField.placeholder = @"name";
    [self.view addSubview:self.textField];
    
    [self.view addSubview: self.tableView];
}

- (void)btnClick:(UIButton *)sender  {
    
    switch (sender.tag) {
        case 100:
            [self insert];
            break;
            
        case 101:
            [self query:self.textField.text];
            break;
            
        case 102:
            if(!self.selectPerson) {
                NSLog(@"请先选择");
                return;
            }else if(self.textField.text.length == 0) {
                NSLog(@"请输入要修改name");
                return;
            }
            [self modify:self.selectPerson];
            break;
            
        case 103:
            if (!self.selectPerson) {
                NSLog(@"请先选择");
                return ;
            }
            [self delete:self.selectPerson];
            break;
            
        default:
            break;
    }

    self.selectPerson = nil;
}

-(void)insert {
    
    NSArray *perArr = @[@"张三",@"李四",@"王五",@"赵六"];
    NSArray *departmentArr = @[@"android",@"ios"];
    
    Department *depart = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.context];
    depart.name = [NSString stringWithFormat:@"%@",departmentArr[arc4random()%2]];
    depart.departmentNo = [NSString stringWithFormat:@"%i",arc4random()%100];
    
    Person *per = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.context];
    per.name = [NSString stringWithFormat:@"%@%i",perArr[arc4random()%4],arc4random()%100];
    per.relationship = depart;
    per.age = @(arc4random()%100);
    
    NSError *error = nil;
    
    [self.context save:&error];
    
    
    if(error) {
        NSLog(@"error:%@",error);
    }
    

}

-(void)modify:(Person *)per {

    NSFetchRequest *requset = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",per.name];
    if (!(per.name == nil || [per.name isEqualToString:@""])) {
        requset.predicate = predicate;
    }
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    requset.sortDescriptors = @[sort];
    
    NSError *error = nil;
   NSArray *arr =  [self.context executeFetchRequest:requset error:&error];
    
    if(error) {
        NSLog(@"error :%@",error);
    }
    
    for (Person *per  in arr) {
        per.name = self.textField.text;
    }
    
    [self.context save:&error];
    
}

-(void)query:(NSString *)name  {

    //设置查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    //设置查询条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
    if(!(name == nil || [name isEqualToString:@""])) {
        request.predicate = predicate;
    }
    //设置排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    NSArray *queryArr = [self.context executeFetchRequest:request error:&error];
    if(error) {
        NSLog(@"error:%@",error);
    }
    
    self.dataSource = queryArr;
    [self.tableView reloadData];
    
}


-(void)delete:(Person *)per  {

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",per.name];
    if(!(per.name == nil || [per.name isEqualToString:@""])) {
        request.predicate = predicate;
    }
    
    NSError *error = nil;
    NSArray *arr = [self.context executeFetchRequest:request error:&error];
    if(error) {
        NSLog(@"error :%@",error);
    }
    
    for (Person *per  in arr) {
        [self.context deleteObject:per];
    }
    
    [self.context save:&error];
    if (error) {
        NSLog(@"error %@",error);
    }
}


#pragma mark - tableView data source 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - tableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    Person *per = self.dataSource[indexPath.row];
    Department *depart = per.relationship;
    cell.textLabel.text  = [NSString stringWithFormat:@"name:%@ age:%@ department:%@ departmentNo:%@",per.name,per.age,depart.name,depart.departmentNo];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectPerson = self.dataSource[indexPath.row];
}

@end
