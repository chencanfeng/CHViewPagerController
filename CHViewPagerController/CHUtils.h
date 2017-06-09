//
//  CHUtils.h
//  CHViewPagerController
//
//  Created by 陈灿锋 on 2017/6/9.
//  Copyright © 2017年 陈灿锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHUtils : NSObject

@end

@interface UIImage (UIImage_Bundle)
+ (UIImage *)imageNamed:(NSString *)name bundle:(NSBundle *)bundle;
@end

@interface UIImage (colorsize)
+ (UIImage *)imageWithColor:(UIColor *)color;
-(UIImage*)resize:(CGSize)size;
@end

@interface UIColor (UIColor_Expanded)
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end

@interface NSString (size)

- (CGSize)sizeWithAttributeFont:(UIFont *)font;
- (CGSize)sizeWithAttributeFont:(UIFont *)font forWidth:(int)width;

@end
