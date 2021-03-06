//
//  NSDate+LTYExtension.h
//
//  Created by AYuan on 16/3/16.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LTYExtension)

/**
 比较from和self的时间差值 
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;
/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

@end
