//
//  GYFMDBAddressCityManager.m
//  HSConsumer
//
//  Created by lizp on 16/6/1.
//  Copyright © 2016年 SHENZHEN GUIYI SCIENCE AND TECHNOLOGY DEVELOP CO.,LTD. All rights reserved.
//

#import "GYFMDBAddressCityManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"
#import "GYAddressCityModel.h"

@interface GYFMDBAddressCityManager()

@property (nonatomic,strong) FMDatabaseQueue *queue;

@end

@implementation GYFMDBAddressCityManager

+(GYFMDBAddressCityManager *)shareInstance {

    static dispatch_once_t onceToken;
    static GYFMDBAddressCityManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[GYFMDBAddressCityManager alloc] init];
    });
    return manager;
}

-(instancetype)init {
    if(self = [super init]) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [doc stringByAppendingString:@"/GYAddress.sqlite"];
        _queue = [FMDatabaseQueue databaseQueueWithPath:path];
        NSLog(@"%@",path);
        [self.queue inDatabase:^(FMDatabase *db) {
            if( ![db executeUpdate:@"create table if not exists address_city(cityNo text primary key,cityNameCn text,cityFullName text,delFlag text,population text,postCode text,countryNo text,version text,phonePrefix text,provinceNo text,cityName text)"]) {
                NSLog(@"create address_city fail");
            }
        }];
    }
    return self;
}


-(void)insertCity:(GYAddressCityModel *)model  {

    [self.queue inDatabase:^(FMDatabase *db) {
        if(![db executeUpdate:@"insert into address_city(cityNo,cityNameCn,cityFullName,delFlag,population,postCode,countryNo,version,phonePrefix,provinceNo,cityName) values(?,?,?,?,?,?,?,?,?,?,?)",model.cityNo,model.cityNameCn,model.cityFullName,model.delFlag,model.population,model.postCode,model.countryNo,model.version,model.phonePrefix,model.provinceNo,model.cityName]) {
            NSLog(@"insert address_city fail");
        }
    }];
}

-(NSArray *)executeCity:(NSString *)province {

    NSMutableArray *cityMarr = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *set = [db executeQuery:@"select * from address_city where cityNo = ?",province];
        while ([set next]) {
            GYAddressCityModel *model = [[GYAddressCityModel alloc] init];
            model.cityNameCn = [set stringForColumn:@"cityNameCn"];
            model.cityNo  = [set stringForColumn:@"cityNo"];
            model.cityFullName = [set stringForColumn:@"cityFullName"];
            model.delFlag = [set stringForColumn:@"delFlag"];
            model.population = [set stringForColumn:@"population"];
            model.countryNo  = [set stringForColumn:@"countryNo"];
            model.version = [set stringForColumn:@"version"];
            model.phonePrefix = [set stringForColumn:@"phonePrefix"];
            model.provinceNo = [set stringForColumn:@"provinceNo"];
            model.cityName = [set   stringForColumn:@"cityName"];
            
            [cityMarr addObject:model];
        }
        [set close];
    }];
    return cityMarr;
}


-(void)deleteCity {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        if(![db executeUpdate:@"delete from address_city"]) {
            NSLog(@"delete address_city");
        }
    }];
}

@end
