//
//  LTYWebCachesTool.m
//  WebDataCaches
//
//  Created by AYuan on 16/5/23.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYWebCachesTool.h"
#import "FMDB.h"

@implementation LTYWebCachesTool

static FMDatabase *_db;

+ (void)initialize
{
    //打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    //建表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idster text NOT NULL);"];
    
}

+ (void)saveStatuses:(NSArray *)statuses
{
    // 要将一个对象存进数据库的blob字段,最好先转为NSData
    // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
    //NSDictionary默认遵守了NSCoding协议
    for (NSDictionary *status in statuses) {
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status(status, idstr) VALUES (%@, %@);", statusData,status[@"idStr"]];
    }
    
    for (NSDictionary *status in statuses) {
        // NSDictionary --> NSData
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status(status, idstr) VALUES (%@, %@);", statusData, status[@"idstr"]];
    }

}

+ (NSArray *)statusesWithParams:(NSDictionary *)params
{
    //查询sql
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECTED * FROM t_status WHERE idstr > %@ ODER BY DESC limit 20",params[@"since_id"]];
    }else if (params[@"max_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;", params[@"max_id"]];
    } else {
        sql = @"SELECT * FROM t_status ORDER BY idstr DESC LIMIT 20;";
    }
    
    //执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:statusData];
    }
    
    return statuses;

}


@end
