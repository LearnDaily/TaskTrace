//
//  NSString+RT.m
//  rongtai
//
//  Created by yoghourt on 6/2/15.
//  Copyright (c) 2015 William-zhang. All rights reserved.
//

#import "NSString+RT.h"

@implementation NSString (RT)

+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        
        return YES;
        
    }
    
    if (string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    } 
    
    return NO;
    
} 


@end
