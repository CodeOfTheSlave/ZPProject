//
//  GYFMDBAddressManager.m
//  HSConsumer
//
//  Created by lizp on 16/6/1.
//  Copyright © 2016年 SHENZHEN GUIYI SCIENCE AND TECHNOLOGY DEVELOP CO.,LTD. All rights reserved.
//

#import "GYFMDBAddressProvinceManager.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "GYAddressProvinceModel.h"

@interface GYFMDBAddressProvinceManager()

@property (nonatomic,strong) FMDatabaseQueue *queue;

@end

@implementation GYFMDBAddressProvinceManager


+(GYFMDBAddressProvinceManager *)shareInstance {
    static dispatch_once_t onceToken ;
    static GYFMDBAddressProvinceManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[GYFMDBAddressProvinceManager alloc] init];
        
    });
    return manager;
}

-(instancetype)init {
    self = [super init];
    if(self) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [doc stringByAppendingString:@"/GYAddress.sqlite"];
        NSLog(@"%@",path);
        _queue = [FMDatabaseQueue databaseQueueWithPath:path];
        [_queue inDatabase:^(FMDatabase *db) {
            NSString *provinceTable = [NSString stringWithFormat:@"create table if not exists address_province (provinceNo text primary key,countryNo text,delFlag text,directedCity text,provinceName text,provinceNameCn text,version text)"];
            if(![db executeUpdate:provinceTable]) {
                NSLog(@"create address_province table fail");
            }
        }];
    }
    return self;
}

-(void)insertProvince:(GYAddressProvinceModel *)model {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        if(![db executeUpdate:@"insert into  address_province(countryNo,delFlag,directedCity,provinceName,provinceNameCn,provinceNo,version) values(?,?,?,?,?,?,?)",model.countryNo,model.delFlag,model.directedCity,model.provinceName,model.provinceNameCn,model.provinceNo,model.version]) {
            NSLog(@"insert address_province table fail");
        }
    }];
    
}

-(NSArray *)executeProvince:(NSString *)countryNo {
    
    NSMutableArray *provinceMarr = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"select * from address_province where countryNo = ?",countryNo];
        while ([set next]) {
            GYAddressProvinceModel *model = [[GYAddressProvinceModel alloc] init];
            model.countryNo = [set stringForColumn:@"countryNo"];
            model.delFlag = [set stringForColumn:@"delFlag"];
            model.directedCity = [set stringForColumn:@"directedCity"];
            model.provinceName = [set stringForColumn:@"provinceName"];
            model.provinceNameCn = [set stringForColumn:@"provinceNameCn"];
            model.provinceNo = [set stringForColumn:@"provinceNo"];
            model.version = [set stringForColumn:@"version"];
            [provinceMarr addObject:model];
        }
        [set close];
    }];
    return provinceMarr;
}

-(void)deleteProvince {

    [self.queue inDatabase:^(FMDatabase *db) {
        if(![db executeUpdate:@"delete from address_province"]) {
            NSLog(@"delete address_province fail");
        }
    }];
}



@end
