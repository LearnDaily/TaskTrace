//
//  NSDate+TCUtils.h
//  ActionSheetPicker
//
//  Created by Tim Cinel on 2011-11-14.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDateFormatter+Time.h"
@interface NSDate(TCUtils)
- (NSDate *)TC_dateByAddingCalendarUnits:(NSCalendarUnit)calendarUnit amount:(NSInteger)amount;

/**
 返回当前时间"yyyy-MM-dd HH:mm:ss"
 */
-(NSString *)GetTheCurrentTime;

///比对时间格式为yyyy-MM-dd
+(BOOL)isDay:(NSString*)dateString;
@end
