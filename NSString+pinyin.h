//
//  NSString+pinyin.h
//  qgzh
//
//  Created by niko on 15/6/19.
//  Copyright (c) 2015年 jiaodaocun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (pinyin)
//调用CFStringTransform方法进行汉字转拼音和拼音转英文：
- (NSString *)chineseToPinyin:(NSString *)chineseStr;
@end
