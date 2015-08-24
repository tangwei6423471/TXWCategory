//
//  NSString+Helper.h
//  iOSHelper
//
//  Created by Aigo on 14-7-24.
//  Copyright (c) 2014年 pljhonglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Helper)
- (NSNumber*)numberValue;
- (NSData *)dataValue;

// 去除首尾的空格和换行符
- (NSString *)stringByTrim;

// nil, @"", @"  ", @"\n" will return NO, others will return YES.
- (BOOL)isNotBlank;

- (BOOL)equals:(NSString *)str;

- (CGFloat)heightByFont:(UIFont *)font width:(CGFloat)width;
- (CGSize)sizeByFont:(UIFont *)font width:(CGFloat)width;

/**
 计算中英文混编字符串长度，单位长度包含一个中文字符或者两个英文字符
 @param text 输入字符串
 @returns 返回字符串长度
 */
- (NSInteger)TextLength;


/**
 *  Alvin 根据枚举值 返回指定的关系 名称
 *
 *  @param relation 整形
 *
 *  @return 字符串
 */
//+ (NSString *)stringByRelation:(NSInteger)relation;

/**
 *  是否包含某字符串 alvin
 *
 *  @param motherString 母字符串
 *  @param sonString    子字符串
 *
 *  @return 布尔值
 */
+ (BOOL)stringContentString:(NSString *)motherString subString:(NSString *)sonString;

+ (NSString *)removeSpaceAndNewline:(NSString *)str;// 去掉所有空格和换行线

@end
