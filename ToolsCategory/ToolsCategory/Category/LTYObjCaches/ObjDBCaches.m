//
//  ObjDBCaches.m
//  ObjDBCaches
//
//  Created by AYuan on 16/5/24.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "ObjDBCaches.h"
#import "Dog.h"
#import "FMDB.h"

@implementation ObjDBCaches

static FMDatabase *_db;

+ (void)initialize
{
    // 初始化
    NSString *path = @"/Users/apple/Desktop/dogs.data";
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_dogs (id integer PRIMARY KEY, dog blob NOT NULL);"];

}


- (void)readDogs
{
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_dogs LIMIT 10,10;"];
    while (set.next) {
        NSData *data = [set objectForColumnName:@"dog"];
        Dog *dog = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"%@", dog);
    }
    
    //以下方法需要打开所有数据再查找
    //    NSMutableArray *dogs = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/apple/Desktop/dogs.data"];
    //    NSLog(@"%@", [dogss subarrayWithRange:NSMakeRange(20, 10)]);
}

- (void)addDogs
{
    //    NSMutableArray *dogs = [NSMutableArray array];
    //    for (int i = 0; i<1000; i++) {
    //        Dog *dog = [[Dog alloc] init];
    //        dog.name = [NSString stringWithFormat:@"商品--%d", i];
    //        dog.price = arc4random() % 10000;
    //        [dogs addObject:dog];
    //    }
    //    [NSKeyedArchiver archiveRootObject:dogs toFile:@"/Users/apple/Desktop/dogs.data"];
    for (int i = 0; i<100; i++) {
        Dog *dog = [[Dog alloc] init];
        dog.name = [NSString stringWithFormat:@"dog--%d", i];
        dog.age = arc4random() % 10000;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dog];
        [_db executeUpdateWithFormat:@"INSERT INTO t_dogs(dog) VALUES (%@);", data];
    }
}


@end
