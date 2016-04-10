//
//  UIView+RT.m
//  rongtai
//
//  Created by yoghourt on 8/7/15.
//  Copyright (c) 2015 William-zhang. All rights reserved.
//

#import "UIView+RT.h"

@implementation UIView (RT)

//将UIView转成UIImage
+ (UIImage *)getImageFromView:(UIView *)theView {
	//UIGraphicsBeginImageContext(theView.bounds.size);
	UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, 0);
	[theView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
