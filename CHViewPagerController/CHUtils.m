//
//  CHUtils.m
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import "CHUtils.h"

@implementation CHUtils

@end

@implementation UIImage (UIImage_Bundle)

+ (UIImage *)imageNamed:(NSString *)name bundle:(NSBundle *)bundle{
    if(bundle == nil){
        return [UIImage imageNamed:name];
    }
    
    NSString* extensiton = [name pathExtension];
    if (extensiton) {
        name = [name stringByDeletingPathExtension];
    }else{
        extensiton = @"png";
    }
    NSString *imagePath = [bundle pathForResource:[name stringByAppendingString:@"@2x"] ofType:extensiton];
    if(imagePath == nil){
        imagePath = [bundle pathForResource:name ofType:@"png"];
        if(imagePath == nil){
            return [UIImage imageNamed:name];
        }
        
    }
    
    return [[UIImage alloc]initWithContentsOfFile:imagePath];
}

@end




@implementation  UIImage (colorsize)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage*)resize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end




@implementation UIColor (UIColor_Expanded)
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}
+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
@end




@implementation NSString (size)

- (CGSize) sizeWithAttributeFont:(UIFont *)font{
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        return [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
    }else{
        return [self sizeWithFont:font forWidth:MAXFLOAT lineBreakMode:NSLineBreakByCharWrapping];
    }
}

- (CGSize)sizeWithAttributeFont:(UIFont *)font forWidth:(int)width{
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName: font} context:nil].size;
    }else{
        return [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }
}
@end

