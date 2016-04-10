//
//  UIImage+ImageBlur.m
//  rongtai
//
//  Created by William-zhang on 15/6/29.
//  Copyright (c) 2015年 William-zhang. All rights reserved.
//

#import "UIImage+ImageBlur.h"

@implementation UIImage (ImageBlur)

#pragma mark - 根据参数返回一张模糊照片
-(UIImage*)blurImage:(CGFloat)blur
{
    CIContext* context = [CIContext contextWithOptions:nil];
    CIImage* old = [CIImage imageWithCGImage:self.CGImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:old forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:blur] forKey:@"inputRadius"];
    CIImage* output = [filter valueForKey:kCIOutputImageKey];
    CGRect r = [output extent];
    //ios9适配
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        NSLog(@"ios9");
        r.origin.x += 7*blur;
        r.origin.y += 7*blur;
        r.size.width  -= 14*blur;
        r.size.height -= 14*blur;
    }
    else
    {
        r.origin.x += 4*blur;
        r.origin.y += 4*blur;
        r.size.width  -= 8*blur;
        r.size.height -= 8*blur;
    }
    NSLog(@"rect:%@",NSStringFromCGRect(r));

    CGImageRef ref  = [context createCGImage:output fromRect:r];
    UIImage* new = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return new;
}

#pragma mark - Image保存到本地
-(void)saveImageByName:(NSString*)fileName
{
    NSString* doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString* path = [doc stringByAppendingPathComponent:fileName];
    NSLog(@"头像路径:%@",path);
    NSData* data = UIImagePNGRepresentation(self);
    [data writeToFile:path atomically:YES];
}

#pragma mark - 读取本地图片
+(UIImage*)imageInLocalByName:(NSString*)fileName
{
    NSString* doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString* path = [doc stringByAppendingPathComponent:fileName];
    UIImage* img = [[UIImage alloc]initWithContentsOfFile:path];
    return img;
}


/////

#pragma mark - 自动压缩
-(UIImage*)autoCompress
{
    //把图片控制在200k左右
    NSData* data = UIImageJPEGRepresentation(self, 1.0);
//    NSLog(@"原图大小：%ld",data.length);
    UIImage* image;
    if (data.length/1024.0 > 130) {
//        NSLog(@"图片大小超过要求，大小约为：%.2fK",data.length/1024.0);
        //计算需要压缩的比例
        CGFloat percent = 160*1024.0/data.length;
//        NSLog(@"图片压缩率：%.2f",percent);
        image = [self compressImageBySizePercent:percent];
        image = [image compressImageByQualityPercent:percent];
    }
    if (image) {
//        NSLog(@"图片压缩后大小为：%ld",[UIImageJPEGRepresentation(image,1.0) length]);
        return image;
    }
    else
    {
        return self;
    }
}

#pragma mark -  尺寸压缩
-(UIImage*)compressImageBySizePercent:(CGFloat)percent
{
    CGSize size = self.size;
    size.width = size.width * percent;
    size.height = size.height * percent;
    UIGraphicsBeginImageContext(size);
    CGRect f = CGRectZero;
    f.size = size;
    [self drawInRect:f];
    UIImage* new = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return new;
}

#pragma mark - 质量压缩
-(UIImage*)compressImageByQualityPercent:(CGFloat)percent
{
    NSData* data = UIImageJPEGRepresentation(self, percent);
    //    NSLog(@"压缩率：%.2f,压缩后大小：%ld",percent,data.length);
    UIImage* newImage = [UIImage imageWithData:data];
    return newImage;
}


@end
