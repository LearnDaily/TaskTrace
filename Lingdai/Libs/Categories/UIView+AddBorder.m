//
//  UIView+AddBorder.m
//  rongtai
//
//  Created by William-zhang on 15/7/16.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "UIView+AddBorder.h"

@implementation UIView (AddBorder)

#pragma mark - 加边框
-(void)addLineBorder
{
    CGRect f = self.bounds;
    f.size.height = 1;
    f.origin.y = 0;
    UIView* bl1 = [self blackLine:f];
    [self addSubview:bl1];
    
    f.origin.y = 1;
    UIView* wl1 = [self whiteLine:f];
    [self addSubview:wl1];
    
    f.origin.y = self.bounds.size.height - 1;
    UIView* wl2 = [self whiteLine:f];
    [self addSubview:wl2];
    
    f.origin.y ++;
    UIView* bl2 = [self blackLine:f];
    [self addSubview:bl2];
}

-(UIView*)blackLine:(CGRect)frame
{
    UIView* blackLine = [[UIView alloc]initWithFrame:frame];
    blackLine.backgroundColor = [UIColor colorWithRed:116/255.0 green:154/255.0 blue:180/255.0 alpha:0.1];
    return blackLine;
}

-(UIView*)whiteLine:(CGRect)frame
{
    UIView* whiteLine = [[UIView alloc]initWithFrame:frame];
    whiteLine.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    return whiteLine;
}

@end
