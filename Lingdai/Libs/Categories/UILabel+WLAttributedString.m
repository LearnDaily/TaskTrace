//
//  UILabel+WLAttributedString.m
//  WLPickerView
//
//  Created by William-zhang on 15/6/23.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "UILabel+WLAttributedString.h"

@implementation UILabel (WLAttributedString)


#pragma mark - 设置Label的内容中数字的格式
-(void)setNumebrByFont:(UIFont*)font Color:(UIColor*)color
{
    NSArray* arr = [self numberRangeOfString:[self.attributedText string]];
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    NSDictionary* dic = [[NSDictionary alloc]initWithObjectsAndKeys:font,NSFontAttributeName,color,NSForegroundColorAttributeName, nil];
    for (int i = 0; i<arr.count; i++) {
        NSRange r = [arr[i] rangeValue];
        [string setAttributes:dic range:r];
    }
    self.attributedText = string;
}


#pragma mark - 返回字符中所有数字的范围
-(NSArray*)numberRangeOfString:(NSString*)string
{
    NSCharacterSet* numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    NSUInteger index = 0;
    NSUInteger length = 0;
    NSMutableArray* ranges = [NSMutableArray new];
    for (int i = 0; i < string.length; i++) {
//        NSLog(@"subChar:%c",[string characterAtIndex:i]);
        if ([numberSet characterIsMember:[string characterAtIndex:i]]) {
            length++;
            if (i == string.length - 1) {
                NSRange r = NSMakeRange(index, length);
                [ranges addObject:[NSValue valueWithRange:r]];
            }
        }
        else
        {
            if (length>0) {
                NSRange r = NSMakeRange(index, length);
                [ranges addObject:[NSValue valueWithRange:r]];
            }
            index = i+1;
            length = 0;
        }
    }
    return [NSArray arrayWithArray:ranges];
}

@end
