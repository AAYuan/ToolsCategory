//
//  Dog.m
//  ObjDBCaches
//
//  Created by AYuan on 16/5/24.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "Dog.h"

@implementation Dog 

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    
    return self;
}

/*
 * description方法会将对象转为字符串
 */
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ <-> %ld", self.name, self.age];
}

@end
