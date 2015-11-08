//
//  UIColor+LZMAddColor.m
//  LZIOSPro_Moran
//
//  Created by comst on 15/11/9.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#define LZRANGE(a,b)  NSMakeRange((a), (b))

#import "UIColor+LZMAddColor.h"

@implementation UIColor (LZMAddColor)
+ (UIColor *)colorFromHexCode:(NSString *)hexString{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
       cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@", [cleanString substringWithRange:LZRANGE(0, 1)], [cleanString substringWithRange:LZRANGE(0, 1)], [cleanString substringWithRange:LZRANGE(1, 1)], [cleanString substringWithRange:LZRANGE(1, 1)], [cleanString substringWithRange:LZRANGE(2, 1)], [cleanString substringWithRange:LZRANGE(2, 1)]];
    }
    if ([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
        
    }
    
    unsigned int value ;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&value];
    
    CGFloat red = ((value >> 24) & 0xFF) / 255.0;
    CGFloat green = ((value >> 16) & 0xFF) / 255.0;
    CGFloat blue = ((value >> 8) & 0xFF) / 255.0;
    CGFloat alpha = ((value >> 0) & 0xFF) / 255.0;
    
    return [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
}
@end
