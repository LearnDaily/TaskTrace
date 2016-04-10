//
//  NSDateFormatter+Time.h
//  iBreath
//
//  Created by YUYE on 15/7/14.
//  Copyright (c) 2015年 YUYE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Time)
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

/**
 返回 YYYY-MM-dd HH:mm:ss
 */
+ (id)defaultDateFormatter;/**HH:mm*/

+ (id)dateTypeFormatter;

+ (id)timeTypeFormatter;
@end
