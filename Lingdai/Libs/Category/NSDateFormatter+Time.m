//
//  NSDateFormatter+Time.m
//  iBreath
//
//  Created by YUYE on 15/7/14.
//  Copyright (c) 2015年 YUYE. All rights reserved.
//

#import "NSDateFormatter+Time.h"

@implementation NSDateFormatter (Time)

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];

    dateFormatter.dateFormat = dateFormat;

    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"YYYY-MM-dd HH:mm:ss"];
}

+ (id)dateTypeFormatter
{
    return [self dateFormatterWithFormat:@"YYYY-MM-dd"];
}

+ (id)timeTypeFormatter
{
    return [self dateFormatterWithFormat:@"HH:mm:ss"];
}
@end
