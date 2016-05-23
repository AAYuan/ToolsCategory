//
//  Dog.h
//  ObjDBCaches
//
//  Created by AYuan on 16/5/24.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject <NSCoding>

/** 年龄 */
@property (nonatomic, assign) NSInteger age;
/** 名字 */
@property (nonatomic, copy) NSString *name;

@end
