//
//  NSString+pinyin.m
//  qgzh
//
//  Created by niko on 15/6/19.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import "NSString+pinyin.h"

@implementation NSString (pinyin)
//调用CFStringTransform方法进行汉字转拼音和拼音转英文：
- (NSString *)chineseToPinyin:(NSString *)chineseStr{
    if ([chineseStr length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:chineseStr];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {// 汉子转成带音标的拼音
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {// 去掉带音标的拼音
                return ms;
            }
        }
    }
    return @"";
}

@end
